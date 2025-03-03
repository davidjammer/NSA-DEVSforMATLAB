classdef am_or2 < handle
  %% Description
  %  logical or gate, 
  %  works with logical or IEEE1164 values
  %  initial output value 0 or "U"
  %% Ports
  %  inputs:
  %    in1, in2 incoming values
  %  outputs:
  %    out      output value
  %% States
  %  s: init/running
  %  i1,i2 last input values
  %% System Parameters
  %  name:  object name
  %  i0:    initial value of both states and output
  %  debug: flag to enable debug information
  %  tau:   infinitesimal delay

  properties
    s
    i1
    i2
    name
    i0
    debug
    tau
  end

  methods
    function obj = am_or2(name, i0, tau, debug)
      obj.s = "init";
      obj.i0 = i0;
      obj.i1 = i0;
      obj.i2 = i0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      obj.s = "running";

      if isfield(x, "in1")
        obj.i1 = x.in1;
      end
      if isfield(x, "in2")
        obj.i2 = x.in2;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.i1;
      s2 = obj.i2;
      if isfield(x, "in1")
        s1 = x.in1;
      end
      if isfield(x, "in2")
        s2 = x.in2;
      end

      if islogical(s1) && islogical(s2)
        y.out = s1 || s2;
      elseif islogical(s1)   % s2 is still "U"
        y.out = s1;
      else
        y.out = ieee1164_or(s1, s2);
      end

      if obj.debug && isfield(y, "out")
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end
    end

    function t = ta(obj)
      if obj.s == "init"
        t = obj.tau;
      else
        t = [inf, 0];
      end
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s i1=%3d i2=%3d\n", obj.s, obj.i1, obj.i2);
    end

  end
end
