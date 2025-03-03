classdef am_add2 < handle
  %% Description
  %  adds two inputs
  %% Ports
  %  inputs:
  %    in1, in2 incoming values
  %  outputs:
  %    out      sum of input values
  %% States
  %  s:        running
  %  in1,in2:  current input values
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    in1
    in2
    name
    tau
    debug
  end

  methods
    function obj = am_add2(name, tau, debug)
      obj.s = "running";
      obj.in1 = 0;
      obj.in2 = 0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      if isfield(x, "in1")
        obj.in1 = x.in1;
      end
      if isfield(x, "in2")
        obj.in2 = x.in2;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.in1;
      s2 = obj.in2;
      if isfield(x, "in1")
        s1 = x.in1;
      end
      if isfield(x, "in2")
        s2 = x.in2;
      end
      y.out = s1 + s2;

      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s u1=%3d u2=%3d\n", obj.s, obj.in1, obj.in2);
    end

  end
end
