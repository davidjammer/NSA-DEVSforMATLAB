classdef smallestin4 < handle
%% Description
%  outputs index of smallest input value among 4 inputs
%% Ports
%  inputs: 
%    in1, in2, in3 , in4  incoming values
%  outputs: 
%    out      index of smallest input
%% States
%  s: running
%  n1,n2,n3,n4: arrived values
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
 
  properties
    s
    n1
    n2
    n3
    n4
    name
    val0
    debug
    tau
  end
  
  methods
      function obj = smallestin4(name, val0, tau, debug)
      obj.s = "running";
      obj.n1 = val0;
      obj.n2 = val0;
      obj.n3 = val0;
      obj.n4 = val0;
      obj.name = name;
      obj.val0 = val0;
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
      if isfield(x, "in4")
        obj.n4 = x.in4;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
      vals = [obj.n1, obj.n2, obj.n3, obj.n4];
      if isfield(x, "in1")
        vals(1) = x.in1;
      end
      if isfield(x, "in2")
        vals(2) = x.in2;
      end
      if isfield(x, "in3")
        vals(3) = x.in3;
      end
      if isfield(x, "in4")
        vals(4) = x.in4;
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
      fprintf("  phase=%s n1/2/3/4=%2d/%2d/%2d/%2d\n", ...
        obj.s, obj.n1, obj.n2, obj.n3, obj.n4);
    end  

  end
end
