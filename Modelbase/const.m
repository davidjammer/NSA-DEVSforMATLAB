classdef const < handle
%% Description
%  set const. output
%% Ports
%  inputs: 
%  outputs: 
%    out      
%% States
%  s:   running
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
%  value:   const. value    
  properties
    s
    name
    debug
    tau
    value
  end
  
  methods
    function obj = const(name, tau, debug, value)
      obj.s ="running"; 
      obj.name = name;
      obj.value = value;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
	 obj.s = "stop";
    end
                  
    function y = lambda(obj,e,x)
      y.out = obj.value;
    end
    
    function t = ta(obj)
	   if obj.s == "running"
		  t = obj.tau;
	   else
		t = [inf, 0];
	   end
    end
   
  end
end
