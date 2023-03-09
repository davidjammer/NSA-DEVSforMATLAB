classdef add4 < handle
%% Description
%  adds four inputs
%% Ports
%  inputs: 
%    in1, in2, in3, in4 incoming values
%  outputs: 
%    out      sum of input values
%% States
%  s: running
%  u1,u2,u3,u4: current input values
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay

  properties
    s
    u1
    u2
    u3
    u4
    name
    debug
    tau
  end
    
  methods
    function obj = add4(name, tau, debug)
      obj.s = "running";
      obj.u1 = 0;
      obj.u2 = 0;
      obj.u3 = 0;
	 obj.u4 = 0;
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
	 if isfield(x, "in4")
        obj.u4 = x.in4;
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
	 s4 = obj.u4;
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
      y.out = s1 + s2 + s3 + s4;
      
      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end
    end    
       
    function t = ta(obj)
      t = [inf, 0];
    end
    
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s u1=%3d u2=%3d u3=%d u4=%d\n", obj.s, obj.u1, obj.u2, obj.u3, obj.u4);
    end  

  end
end
