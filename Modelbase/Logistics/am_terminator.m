classdef am_terminator < handle
  %  Terminates incoming entities.
  %  Outputs total number of incoming entities.
  %% Ports
  %  inputs:
  %    in       incoming value
  %  outputs:
  %    n        total number of arrived entities
  %% States
  %  s:        running
  %  n:        total number of arrived entities
  %  E:        last incoming entity (for debugging purposes)
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    n
    E
    name
    tau
    debug
  end

  methods
    function obj = am_terminator(name, tau, debug)
      obj.name = name;
      obj.s = "running";
      obj.n = 0;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta,", obj.name)
        showState(obj);
      end

      if ~isempty(x) && isfield(x,"in") && ~isempty(x.in)
        obj.n = obj.n + 1;
        obj.E = x.in;
      end

      if obj.debug
        fprintf("%-8s leaving delta,", obj.name)
        showState(obj);
      end
    end

    function y=lambda(obj,e,x)
      y=[];
      if ~isempty(x) && isfield(x,"in") && ~isempty(x.in)
        y.n = obj.n + 1;
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      t = [Inf,0];
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s", obj.s)
      fprintf(" n=%1d", obj.n);
      if ~isempty(obj.E)
        fprintf(" E=[ %s] ", getDescription(obj.E));
      end
      fprintf("\n")
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in")
        fprintf("[ %s] ", getDescription(x.in));
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "n")
        fprintf("n=%1d", y.n);
      end
      fprintf("\n")
    end  end
end
