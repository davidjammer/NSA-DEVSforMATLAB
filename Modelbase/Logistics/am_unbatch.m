classdef am_unbatch < handle
  %% Description
  %  unbatches the incoming batch entity
  %% Ports
  %  inputs:
  %    in       ingoing batch entity
  %  outputs:
  %    out      outgoing unbatched entities
  %    working  true if processing batch
  %% States
  %  s    idle|busy
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
      obj.s = "idle";
      obj.E = [];
      obj.n = 0;
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

      switch obj.s
        case "idle"
          if ~isempty(x) && isfield(x, "in")&& isfield(x.in, "E")
            obj.E = x.in.E;
            obj.n = 1;
            obj.s = "busy";
          end
        case "busy"
          if obj.n < numel(obj.E)
            obj.n = obj.n + 1;
          else
            obj.E = [];
            obj.n = 0;
            obj.s = "idle";
          end
      end

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
      end
    end

    function y = lambda(obj,e,x)
      y = [];
      switch obj.s
        case "idle"
          y.working = true;
        case "busy"
          y.out = obj.E(obj.n);
          if obj.n == numel(obj.E)
            y.working = false;
          end
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      if obj.s == "busy"
        t = obj.tD;
      else
        t = [inf, 0];
      end
    end

    %-------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%4s\n", obj.s);
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
