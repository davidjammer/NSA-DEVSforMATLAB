classdef generator_raw_part < handle
%% Description
%  generates entities with fixed interarrival times
%% Ports
%  inputs: 
%    enable
%  outputs: 
%    out      generated entities
%% States
%  s:  prod  (fix)  
%  id: number of workpieces generated
%% System Parameters
%  tG: time interval between new entities
%  id: id of first entity
%  name:  object name
%  debug: flag to enable debug information
%    
    properties
	   s
	   name
	   ts
	   sigma
	   id
	   epsilon = get_epsilon;
	   tau
    end
    methods
	   function obj = generator_raw_part(name,ts,tau)
		  obj.name = name;
		  obj.s = 'prod';
		  obj.ts = ts;
		  obj.sigma = obj.ts;
		  obj.id = 0;
		  obj.tau = tau;
	   end
	   function delta(obj,e,x)
		  if ~isempty(x) && isfield(x, "enable") && x.enable == 0
			 obj.s = "stop";
		  elseif ~isempty(x) && isfield(x, "enable") && x.enable == 1 && obj.s == "stop"
			 obj.s = "prod";
		  elseif abs(e(1) - obj.sigma) <= obj.epsilon
			 obj.s = "prod";
			 obj.sigma = obj.ts;
			 obj.id = obj.id + 1;
		  else
			 obj.sigma = obj.sigma - e(1);
		  end
	   end
	   function y=lambda(obj,e,x)
		  
		  if ~isempty(x) && isfield(x, "enable") && x.enable == 0
		      y = [];
		  elseif obj.s == "prod" && abs(e(1) - obj.sigma) <= obj.epsilon
			 E.id = obj.id;
			 E.proc_time = 0;
			 E.start_time = 0;
			 E.end_time = 0;
			 E.energy = 0;
			 y.out = E;
		  else
			 y=[];
		  end
	   end
	   function t = ta(obj)
		  if obj.s == "stop"
			 t = [inf, 0];
		  else
			 t = [obj.sigma, 0];
		  end
	   end
    end
    
end
