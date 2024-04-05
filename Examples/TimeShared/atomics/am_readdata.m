classdef am_readdata < handle
%% Description
%  Outputs value of a data field from the input entity.
%% Ports
%  inputs: 
%    in       incoming struct
%  outputs: 
%    out      outgoing struct
%    val      value read from the input entity
%% States
%  s:   running
%% System Parameters
%  name:    object name
%  field:   field name to be read
%  tau:     infinitesimal delay
%  debug:   flag to enable debug information
    
  properties
    s
    name
    field
    tau
    debug
  end
  
  methods
    function obj = am_readdata(name, field, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.field = field;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      y.out = x.in;
      if ~isempty(y.out)
        y.val = y.out.(obj.field);
      end

      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=%2d\n", obj.name, x.in, y.out);
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
