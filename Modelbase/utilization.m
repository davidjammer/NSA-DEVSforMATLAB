classdef utilization < handle
%% Description
%  calculate the utilization
%% Ports
%  inputs: 
%    in
%  outputs: 
%    out   
%% States
%  s: running
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay

  properties
    s
    active_time
    total_time
    time
    name
    debug
    tau
  end
    
  methods
    function obj = utilization(name, tau, debug)
      obj.s = "idle";
      obj.active_time = 0;
      obj.total_time = 0;
	 obj.time = 0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
	   obj.time = obj.time + e(1);
	   if ~isempty(x)
		  if isfield(x, "in") && x.in == 1
			if obj.s == "idle"
			    obj.total_time = obj.total_time + obj.time; 
			    obj.s = "working";
			    obj.time = 0;
			end
		  elseif isfield(x, "in") && x.in == 0
			if obj.s == "working"
			    obj.total_time = obj.total_time + obj.time;
			    obj.active_time = obj.active_time + obj.time;
			    obj.s = "idle";
			    obj.time = 0;
			end
		  end 
	   end 
    end
    
    function y = lambda(obj,e,x)
	   t = obj.time + e(1);
	   total_time = obj.total_time;
	   active_time = obj.active_time;
	   
	   if ~isempty(x)
		  if isfield(x, "in") && x.in == 1
			 if obj.s == "idle"
				total_time = obj.total_time + t;
			 end
		  elseif isfield(x, "in") && x.in == 0
			 if obj.s == "working"
				total_time = obj.total_time + t;
				active_time = obj.active_time + t;
			 end
		  end
	   end
	   y.out = active_time/total_time;
    end
       
    function t = ta(obj)
      t = [inf, 0];
    end
    
 

  end
end
