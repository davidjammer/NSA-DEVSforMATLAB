classdef div < handle
%% Description
%  divided in1 by in2
%% Ports
%  inputs: 
%    in1       incoming value
%	in2       incoming value
%  outputs: 
%    out      
%% States
%  s:   running
%% System Parameters
%  in1:     
%  in2:
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
    
  properties
    s
    in1
    in2
    name
    debug
    tau
  end
  
  methods
    function obj = div(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.in1 = 0;
	 obj.in2 = 0;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if ~isempty(x)
		if isfield(x, "in1")
		    obj.in1 = x.in1;
		end
		if isfield(x, "in2")
		    obj.in2 = x.in2;
		end
	 end
    end
                  
    function y = lambda(obj,e,x)
	 in1 = obj.in1;  
	 in2 = obj.in2;
	 if ~isempty(x)
		if isfield(x, "in1")
		    in1 = x.in1;
		end
		if isfield(x, "in2")
		    in2 = x.in2;
		end
	 end
	 if in2 == 0
		y = [];
	 else
		y.out = in1 / in2;
	 end
	 
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
