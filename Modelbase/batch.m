classdef batch < handle
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
    function obj = batch(name, N, tau, debug)
      obj.s = "running";
      obj.E = [];
      obj.n = 0;
      obj.N = N;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if ~isempty(x)
   		  obj.E = [obj.E, x.in];
        obj.n = obj.n + 1;
      end

      if obj.n == obj.N
        obj.n = 0;
        obj.E = [];
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

    end

    function t = ta(obj)
      t = [inf, 0];
    end
    
  end
end
