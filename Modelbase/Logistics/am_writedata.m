classdef am_writedata < handle
%% Description
%  Changes value of an incoming data field using values from other fields.
%  If an incoming entity has no corresponding field, it passes unchanged.
%% Ports
%  inputs: 
%    in       incoming struct
%  outputs: 
%    out      outgoing struct
%% States
%  s:   running
%% System Parameters
%  name:       object name
%  inFields:   field names that are used in change function
%  outField:   name of field, whose value is being changed
%  changeFunc: changing function of the form "val = f(v(i));"
%  tau:        infinitesimal delay
%  debug:      flag to enable debug information
    
  properties
    s
    inFields
    outField
    changeFunc
    name
    tau
    debug
  end
  
  methods
    function obj = am_writedata(name, inFields, outField, changeFunc, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.inFields = inFields;
      obj.outField = outField;
      obj.changeFunc = changeFunc;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      if isfield(x.in, obj.outField) 
        y.out = x.in;  

        nInVals = length(obj.inFields);
        in = zeros(nInVals, 1);
        for I = 1:nInVals
          in(I) = getfield(y.out, obj.inFields(I));
        end

        eval(obj.changeFunc);
        y.out = setfield(y.out, obj.outField, out);
      else
        y.out = x.in;
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
