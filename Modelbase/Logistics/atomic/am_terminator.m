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
      obj.s = "idle";
      obj.n = 0;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in, E=%2d\n", obj.name, obj.E)
      end
      if ~isempty(x) && isfield(x,"in")
        obj.n = obj.n + 1;
        obj.E = x.in;
      end

      if obj.debug
        fprintf("%-8s delta out, E=%2d\n", obj.name, obj.E)
      end
    end

    function y=lambda(obj,e,x)
      y=[];
      if ~isempty(x) && isfield(x,"in")
        y.n = obj.n + 1;
      end

      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=[]\n", obj.name, x.in);
      end
    end

    function t = ta(obj)
      t = [Inf,0];
    end

  end
end
