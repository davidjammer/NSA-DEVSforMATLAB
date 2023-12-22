classdef am_not < handle
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
    i1
    name
    debug
    tau
  end
  
  methods
    function obj = am_not(name, tau, debug)
      obj.s = "running";
      obj.name = name;
      obj.i1 = "U";
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e, x)
      if obj.debug
        fprintf("%-8s entering int, being in phase %s\n", obj.name, obj.s)
      end
      if isfield(x, "in")
        obj.i1 = x.in;
      end
    end
   
    function y = lambda(obj, e, x)
      s = obj.i1;
      if isfield(x, "in")
        s = x.in;
      end
      y.out = ieee1164_not(s);

      if obj.debug
        fprintf("%-8s OUT, q=%1d\n", obj.name, y.out)
      end
    end
    
    function t = ta(obj)
      t = inf;
    end
        
  end
end
