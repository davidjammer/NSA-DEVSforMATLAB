classdef batch < handle
%% Description
%  combine n entitys to 1 entity 
%% Ports
%  inputs: 
%    in
%  outputs: 
%    out
%    n
%% States
%  E
%  n
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay

  properties
    s
    E
    Eout
    n
    N
    name
    debug
    tau
  end
    
  methods
    function obj = batch(name, tau, debug, N)
      obj.s = "idle";
      obj.E = [];
	 obj.Eout = [];
      obj.n = 0;
	 obj.N = N;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
    
	   if ~isempty(x)
		 obj.E = [obj.E, x.in];
		 obj.n = obj.n + 1;
	   end
	   
	   if obj.n == obj.N
		  obj.n = 0;
		  obj.E = [];
	   end
    end
    
    function y = lambda(obj,e,x)
	   if ~isempty(x) && isfield(x, "in") && (obj.n + 1) == obj.N
		  E = [obj.E, x.in];
		  Eout.E = E;
		  y.out = Eout;
		  y.n = 0;
	   elseif ~isempty(x) && isfield(x, "in")
		  y.n = obj.n + 1;
	   else
		  y.n = obj.n;
	   end
	   
    end    
       
    function t = ta(obj)
	   
	   t = [inf, 0];
	   
    end
  end
end
