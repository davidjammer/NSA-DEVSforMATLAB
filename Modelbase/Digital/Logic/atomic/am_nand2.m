classdef am_nand2 < handle
  %% Description
  %  logical nand gate, 
  %  initial output value 1 (fix)
  %% Ports
  %  inputs:
  %    in1, in2 incoming values
  %  outputs:
  %    out      output value
  %% States
  %  s: init/running
  %  i1,i2 input values
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
  end

  methods
    function obj = am_nand2(name, tau, debug)
      obj.s = "init";
      obj.i1 = "U";
      obj.i2 = "U";
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

      y.out = ieee1164_not(ieee1164_and(s1,s2)); 

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
      fprintf("  phase=%s i1=%3d i2=%3d\n", obj.s, obj.i1, obj.i2);
    end

  end
end
