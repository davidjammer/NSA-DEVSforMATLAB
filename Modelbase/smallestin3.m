classdef smallestin3 < handle
%% Description
%  outputs index of smallest input value among 3 inputs
%% Ports
%  inputs: 
%    in1, in2, in3   incoming values
%  outputs: 
%    out      index of smallest input
%% States
%  s: running
%  n1,n2,n3: arrived values
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
 
  properties
    s
    n1
    n2
    n3
    name
    debug
    tau
  end
  
  methods
    function obj = smallestin3(name, tau, debug)
      obj.s = "running";
      obj.n1 = 0;
      obj.n2 = 0;
      obj.n3 = 0;
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
        obj.n1 = x.in1;
      end
      if isfield(x, "in2")
        obj.n2 = x.in2;
      end
      if isfield(x, "in3")
        obj.n3 = x.in3;
      end
        
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
      vals = [obj.n1, obj.n2, obj.n3];
      if isfield(x, "in1")
        vals(1) = x.in1;
      end
      if isfield(x, "in2")
        vals(2) = x.in2;
      end
      if isfield(x, "in3")
        vals(3) = x.in3;
      end
      [~, y.out] = min(vals);
      
      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
 
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s n1/2/3=%2d/%2d/%2d\n", ...
        obj.s, obj.n1, obj.n2, obj.n3);
    end  

  end
end
