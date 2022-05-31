classdef combine3B < handle
%% Description
%  combines entities from three inputs into one output
%% Ports
%  inputs: 
%    in1, in2, in3   incoming entities
%  outputs: 
%    out      outgoing entities
%% States
%  s: running
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
    
  properties
    s
    name
    debug
    tau
  end
  
  methods
    function obj = combine3(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s calling delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
      y = [];
      if isfield(x, "in1")
        y.out = [x.in1];
      end
      if isfield(x, "in2")
        y.out = [y.out, x.in2];
      end
      if isfield(x, "in3")
        y.out = [y.out, x.in3];
      end
      
      if obj.debug
        if isfield(y, "out")
          fprintf("%-8s lambda, out=", obj.name)
          fprintf(" %2d", y.out)
          fprintf("\n")
        end
      end
    end
 
    function t = ta(obj)
      t = [inf, 0];
    end
        
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s\n", obj.s)
    end  

  end
end
