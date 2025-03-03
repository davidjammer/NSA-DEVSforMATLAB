classdef am_adddata < handle
%% Description
%  Adds data fields to the input object.
%  If the input is a struct, the new fields are added to the struct.
%  Otherwise a new struct is created and the incoming value is stored in an
%  extra field.
%% Ports
%  inputs: 
%    in       incoming value
%  outputs: 
%    out      outgoing struct
%% States
%  s:   running
%% System Parameters
%  name:    object name
%  fields:  vector of new field names
%  values:  vector of corresponding values
%  numeric: vector of booleans denoting numerical fields
%  infield: field name for incoming value (if not a struct)
%  tau:     infinitesimal delay
%  debug:   flag to enable debug information
    
  properties
    s
    fields
    values
    numeric
    infield
    name
    debug
    tau
  end
  
  methods
    function obj = am_adddata(name, fields, values, numeric, infield, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.fields = fields;
      obj.values = values;
      obj.numeric = numeric;
      obj.infield = infield;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      if isstruct(x.in)
        y.out = x.in;
      else
        y.out = struct(obj.infield, x.in);
      end
      for I = 1:length(obj.fields)
        val = obj.values(I);
        if obj.numeric(I)
          val = str2double(val);
        end
        y.out = setfield(y.out, obj.fields(I), val);
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name);
        fprintf("  in: [ %s], out: [ %s]\n", ...
          getDescription(x.in), getDescription(y.out));
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
