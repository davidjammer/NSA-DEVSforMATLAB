classdef get_max < handle
%% Description
%  outputs the input value if it represents a new maximum
%% Ports
%  inputs: 
%    in       incoming value
%  outputs: 
%    out      
%% States
%  s:   running
%% System Parameters
%  value:     max value
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
    
  properties
    s
    value
    name
    debug
    tau
  end
  
  methods
    function obj = get_max(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.value = 0;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
          if ~isempty(x) && isfield(x, "in") && obj.value < x.in
		    obj.value = x.in;
		end
    end
                  
    function y = lambda(obj,e,x)
        y = [];
	   if ~isempty(x) && isfield(x, "in") && obj.value < x.in
		 y.out = x.in; 
	   end
	   
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
