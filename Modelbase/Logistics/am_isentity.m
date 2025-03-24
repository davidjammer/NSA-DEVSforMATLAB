classdef am_isentity < handle
%% Description
%  checks, whether the incoming event describes an entity
%% Ports
%  inputs: 
%    in       incoming value
%  outputs: 
%    ok       true, if incoming event describes an entity
%% States
%  s:   running
%% System Parameters
%  name:  object name
%  tau:     infinitesimal delay
%  debug: flag to enable debug information
    
  properties
    s
    name
    debug
    tau
  end
  
  methods
    function obj = am_isentity(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      y.ok = isstruct(x.in);
        
      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
    %-------------------------------------------------------
    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in")
        fprintf("[ %s] ", getDescription(x.in));
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "ok")
        fprintf("ok=%s", getDescription(y.ok));
      end
      fprintf("\n")
    end
  end
end
