classdef am_nand4 < handle
  %% Description
  %  logical nand gate, 
  %  initial output value 1 (fix)
  %% Ports
  %  inputs:
  %    in1, in2, in3, in4 incoming values
  %  outputs:
  %    out      output value
  %% States
  %  s: init/running
  %  i1,i2,i3,i4 input values
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:   infinitesimal delay

  properties
    s
    name
    debug
    tau
    i1
    i2
    i3
    i4
  end

  methods
    function obj = am_nand4(name, tau, debug)
      obj.s = "init";
      obj.i1 = "U";
      obj.i2 = "U";
      obj.i3 = "U";
      obj.i4 = "U";
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
      if isfield(x, "in3")
        obj.i3 = x.in3;
      end
      if isfield(x, "in4")
        obj.i4 = x.in4;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.i1;
      s2 = obj.i2;
      s3 = obj.i3;
      s4 = obj.i4;
      if isfield(x, "in1")
        s1 = x.in1;
      end
      if isfield(x, "in2")
        s2 = x.in2;
      end
      if isfield(x, "in3")
        s3 = x.in3;
      end
      if isfield(x, "in4")
        s4 = x.in4;
      end

      y.out = ieee1164_not(ieee1164_and(ieee1164_and(s1,s2),ieee1164_and(s3,s4))); 

      if obj.debug
        if isempty(y)
            fprintf("%-8s lambda, out=[]\n", obj.name)
        else
            fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
        end
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
      fprintf("  phase=%s i1=%3d i2=%3d i3=%3d\n", obj.s, obj.i1, obj.i2, obj.i3);
    end

  end
end
