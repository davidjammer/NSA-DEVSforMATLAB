classdef terminator < handle
%  deletes incoming entities
%  stores incomimg entities for debugging purposes
%% Ports
%  inputs: 
%    in        incoming value
%  outputs: 
%    n
%% States
%  s:        running
%  E:        last incoming value
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:   infinitesimal delay

  properties
    s
    n
    E
    name
    epsilon = get_epsilon;
    debug
    tau
  end
  
  methods
    function obj = terminator(name,tau, debug)
      obj.name = name;
      obj.s = "idle";
	 obj.n = 0;
      obj.debug = debug;
      obj.tau = tau;
    end
    
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in, E=%2d\n", obj.name, obj.E)
      end
      if ~isempty(x) && isfield(x,"in")
		obj.n = obj.n + 1;
		obj.E = x.in;
	 end
      

      if obj.debug
        fprintf("%-8s delta out, E=%2d\n", obj.name, obj.E)
      end
    end
        
    function y=lambda(obj,e,x)
      y=[];
	 if ~isempty(x) && isfield(x,"in")
		y.n = obj.n + 1;
	 end

      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=[]\n", obj.name, x.in);
      end
    end
    
    function t = ta(obj)
      t = [Inf,0]; 
    end
    
  end 
end
