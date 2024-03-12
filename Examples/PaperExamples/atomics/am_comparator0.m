classdef am_comparator0 < handle
%% Description
%  returns 1 if in >= 0, else 0
%% Ports
%  inputs: 
%    in       incoming value
%  outputs: 
%    out      1 if in >= 0, else 0 
%% States
%  s:   running
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:   input delay

  properties
    s
    name
    debug
    tau
  end
  
  methods
    function obj = am_comparator0(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.tau = tau;
      obj.debug = debug;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      if x.in >= 0
        y.out = "1";
      else
        y.out = "0";
      end
      
      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=%2d\n", obj.name, x.in, y.out);
      end
    end
    
    function t = ta(obj)
      t = [inf,0];
    end
   
  end
end
