classdef unstack < handle
%% Description
%  unstack the incoming entity
%% Ports
%  inputs: 
%    in
%  outputs: 
%    out
%% States
%  E
%  pointer
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay

  properties
    s
    E
    pointer
    name
    debug
    tau
  end
    
  methods
    function obj = unstack(name, tau, debug)
      obj.s = "idle";
      obj.E = [];
      obj.pointer = 0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
	   if ~isempty(x)
		 in = x.in;
		 obj.E = in.E;
		 obj.pointer = 2;
	   elseif ~isempty(obj.E)
		  obj.pointer = obj.pointer + 1;
		  
		  if numel(obj.E) < obj.pointer
			obj.E = [];
			obj.pointer = 0;
		  end
	   end
	   
    end
    
    function y = lambda(obj,e,x)
	   y = [];
	   if ~isempty(x)
		  in = x.in;
		  E = in.E;
		  y.out = E(1);
	   else
		  if ~isempty(obj.E)
			y.out = obj.E(obj.pointer); 
		  end
	   end
	   
    end    
       
    function t = ta(obj)
	   if ~isempty(obj.E)
		  t = obj.tau;
	   else
		  t = [inf, 0];
	   end
    end
  end
end
