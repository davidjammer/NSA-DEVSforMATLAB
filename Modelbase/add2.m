classdef add2 < handle
%% Description
%  adds two inputs
%% Ports
%  inputs: 
%    in1, in2 incoming values
%  outputs: 
%    out      sum of input values
%% States
%  s: running
%  u1,u2: current input values
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay

  properties
    s
    u1
    u2
    name
    debug
    tau
  end
    
  methods
    function obj = add2(name, tau, debug)
      obj.s = "running";
      obj.u1 = 0;
      obj.u2 = 0;
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
        
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
      s1 = obj.u1;
      s2 = obj.u2;
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
      fprintf("  phase=%s u1=%3d u2=%3d\n", obj.s, obj.u1, obj.u2);
    end  

  end
end
