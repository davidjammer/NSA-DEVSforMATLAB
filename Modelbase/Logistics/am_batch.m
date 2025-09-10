classdef am_batch < handle
  %% Description
  %  combine N entities to one batch entity
  %% Ports
  %  inputs:
  %    in        incoming entities
  %  outputs:
  %    out       batch of entities
  %    n         current internal batch size
  %% States
  %  s:   running
  %  E:   collection of incoming entities
  %  n:   current number of internal entities
  %% System Parameters
  %  name:  object name
  %  N:     number of input entities to be combined to one output batch
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    E
    n
    name
    N
    tau
    debug
  end

  methods
    function obj = am_batch(name, N, tau, debug)
      obj.s = "running";
      obj.E = [];
      obj.n = 0;
      obj.N = N;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end

      if ~isempty(x)
   		  obj.E = [obj.E, x.in];
        obj.n = obj.n + 1;
      end

      if obj.n == obj.N
        obj.n = 0;
        obj.E = [];
      end

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
      end
    end

    function y = lambda(obj,e,x)
      if ~isempty(x) && isfield(x, "in") && (obj.n + 1) == obj.N
        Eout.E = [obj.E, x.in];
        y.out = Eout;
        y.n = 0;
      elseif ~isempty(x) && isfield(x, "in")
        y.n = obj.n + 1;
      else
        y.n = obj.n;
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end
    
    %-------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  E=%s\n", getDescription(obj.E));
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
