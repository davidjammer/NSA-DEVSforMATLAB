classdef set_proc_time < handle
%% Description
%  
%% Ports
%  inputs: 
%    in       
%  outputs: 
%    out
%    proc_time
%% States
%  t
%  field
%  s:   running
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:   infinitesimal delay
    
  properties
    s
    name
    debug
    tau
  end
  
  methods
    function obj = set_proc_time(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)

    end
                  
    function y = lambda(obj,e,x)
	   if ~isempty(x) && isfield(x, "in")
		 E = x.in;
		 E.proc_time = E.end_time - E.start_time;
		 y.out = E;
		 y.proc_time = E.proc_time;
	   else
		  y = [];
	   end
      
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
