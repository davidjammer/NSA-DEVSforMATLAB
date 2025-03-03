classdef am_add3 < handle
  %% Description
  %  adds three inputs
  %% Ports
  %  inputs:
  %    in1, in2, in3 incoming values
  %  outputs:
  %    out      sum of input values
  %% States
  %  s: running
  %  u1,u2,u3: current input values
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    u1
    u2
    u3
    name
    debug
    tau
  end

  methods
    function obj = am_add3(name, tau, debug)
      obj.s = "running";
      obj.u1 = 0;
      obj.u2 = 0;
      obj.u3 = 0;
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
        obj.u1 = x.in1;
      end
      if isfield(x, "in2")
        obj.u2 = x.in2;
      end
      if isfield(x, "in3")
        obj.u3 = x.in3;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.u1;
      s2 = obj.u2;
      s3 = obj.u3;
      if isfield(x, "in1")
        s1 = x.in1;
      end
      if isfield(x, "in2")
        s2 = x.in2;
      end
      if isfield(x, "in3")
        s3 = x.in3;
      end
      y.out = s1 + s2 + s3;

      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s u1=%3d u2=%3d u3=%d\n", obj.s, obj.u1, obj.u2, obj.u3);
    end

  end
end
