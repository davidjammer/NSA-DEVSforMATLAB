classdef unbatch < handle
  %% Description
  %  unbatches the incoming (batch) entity
  %% Ports
  %  inputs:
  %    in    incoming batch entity
  %  outputs:
  %    out   outgoing unbatched entities
  %% States
  %  s    running
  %  E    incoming batch entity
  %  n    number of next outgoing entity
  %% System Parameters
  %  name:  object name
  %  tD:    time delay between outgoing entities of a batch
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    E
    n
    name
    tD
    tau
    debug
  end

  methods
    function obj = unbatch(name, tD, tau, debug)
      obj.s = "running";
      obj.E = [];
      obj.n = 0;
      obj.name = name;
      obj.tD = tD;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if ~isempty(x)
        in = x.in;
        obj.E = in.E;
        obj.n = 2;
      elseif ~isempty(obj.E)
        obj.n = obj.n + 1;
        if numel(obj.E) < obj.n
          obj.E = [];
          obj.n = 0;
        end
      end
    end

    function y = lambda(obj,e,x)
      y = [];
      if ~isempty(x)
        in = x.in;
        Ei = in.E;
        y.out = Ei(1);
      elseif ~isempty(obj.E)
        y.out = obj.E(obj.n);
      end
    end

    function t = ta(obj)
      if ~isempty(obj.E)
        t = obj.tD;
      else
        t = [inf, 0];
      end
    end
  end
end
