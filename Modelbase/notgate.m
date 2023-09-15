classdef notgate < handle
%% Description
%  logical NOT block
%% Ports
%  inputs: 
%    in
%  outputs: 
%    out
%% States
%  s: running
%% System Parameters
%  name:  object name
%  tau:   input delay
%  debug: flag to enable debug information

  properties
    s
    name
    debug
    tau
  end
  
  methods
    function obj = notgate(name, tau, debug)
      obj.s = "running";
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e, x)
      if obj.debug
        fprintf("%-8s entering int, being in phase %s\n", obj.name, obj.s)
      end
    end
   
    function y = lambda(obj, e, x)
      y.out = ~x.in;

      if obj.debug
        fprintf("%-8s OUT, q=%1d\n", obj.name, y.out)
      end
    end
    
    function t = ta(obj)
      t = inf;
    end
        
  end
end
