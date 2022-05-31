classdef terminator < handle
%  deletes incoming entities
%  stores incomimg entities for debugging purposes
%% Ports
%  inputs: 
%    in        incoming value
%  outputs: 
%    none
%% States
%  s:        running
%  E:        last incoming value
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:   infinitesimal delay

  properties
    s
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
      obj.debug = debug;
      obj.tau = tau;
    end
    
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in, E=%2d\n", obj.name, obj.E)
      end
      
      obj.E = x.in;

      if obj.debug
        fprintf("%-8s delta out, E=%2d\n", obj.name, obj.E)
      end
    end
        
    function y=lambda(obj,e,x)
      y=[];

      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=[]\n", obj.name, x.in);
      end
    end
    
    function t = ta(obj)
      t = [Inf,0]; 
    end
    
  end 
end
