classdef gain < handle
%% Description
%  multiplies its input with a parameter value
%% Ports
%  inputs: 
%    in       incoming value
%  outputs: 
%    out      
%% States
%  s:   running
%% System Parameters
%  name:  object name
%  g:     gain factor
%  tau:     infinitesimal delay
%  debug: flag to enable debug information
    
  properties
    s
    g
    name
    debug
    tau
  end
  
  methods
    function obj = gain(name, g, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.g = g;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      y.out = obj.g*x.in;
        
      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=%2d\n", obj.name, x.in, y.out);
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
