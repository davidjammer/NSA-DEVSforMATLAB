classdef am_unbatch < handle
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
    function obj = am_unbatch(name, tD, tau, debug)
      obj.s = "running";
      obj.E = [];
      obj.n = 1;
      obj.name = name;
      obj.tD = tD;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end

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

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
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

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      if ~isempty(obj.E) && length(obj.E) > 1
        t = obj.tD;
      else
        t = [inf, 0];
      end
    end

    %-------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  E=%s\n", getDescription(obj.E));
      fprintf("  n=%s\n", getDescription(obj.n));
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  input:  %s\n", getDescription(x))
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf("  output: %s\n", getDescription(y))
    end
  end
end
