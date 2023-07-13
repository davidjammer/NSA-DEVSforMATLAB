classdef not_devs < handle
%% Description
%  simple not gate
%% Ports
%  inputs: 
%    in incoming values
%  outputs: 
%    out      output value
%% States
%  s: {}
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  r:     infinitesimal delay

  properties
    s
    name
    debug
    tau
  end
    
  methods
    function obj = not_devs(name, tau, debug)
      obj.s = "running";
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)

    end
    
    function y = lambda(obj,e,x)
      y=[];
      if isfield(x, "in")
        y.out = ~x.in;
	 end
    end    
       
    function t = ta(obj)
           t = [inf, 0];
    end
    

  end
end
