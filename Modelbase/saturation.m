classdef saturation < handle
%% Description
%  Limits the input value to an upper and lower limit
%% Ports
%  inputs: 
%    in       incoming value
%  outputs: 
%    out      
%% States
%  s:   running
%  ul: uper limit
%  ll: lower limit
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
    
  properties
    s
    ul
    ll
    name
    debug
    tau
  end
  
  methods
    function obj = saturation(name, tau, debug, ul, ll)
      obj.s ="running"; 
      obj.name = name;
      obj.ul = ul;
	 obj.ll = ll;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
    
    end
                  
    function y = lambda(obj,e,x)
	   y = [];
	   if ~isempty(x)
		  if x.in < obj.ll
			 y.out = obj.ll;
		  elseif x.in > obj.ul
			 y.out = obj.ul;
		  else
			 y.out = x.in;
		  end
	   end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
