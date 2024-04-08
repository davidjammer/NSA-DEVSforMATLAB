classdef am_deletedata < handle
%% Description
%  Deletes data fields from the input object.
%% Ports
%  inputs: 
%    in       incoming struct
%  outputs: 
%    out      outgoing struct
%% States
%  s:   running
%% System Parameters
%  name:    object name
%  fields:  vector of field names to be deleted
%  tau:     infinitesimal delay
%  debug:   flag to enable debug information
    
  properties
    s
    fields
    name
    debug
    tau
  end
  
  methods
    function obj = am_deletedata(name, fields, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.fields = fields;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      y.out = rmfield(x.in, obj.fields);
   
      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=%2d\n", obj.name, x.in, y.out);
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
