classdef am_multi3 < handle
%% Description
%  multiplies in1 with in2 with in3
%% Ports
%  inputs: 
%    in1, in2, in3  incoming values
%  outputs: 
%    out            outgoing result
%% States
%  s:        running
%  in1/2/3:  current input values
%% System Parameters
%  name:  object name
%  tau:   input delay
%  debug: flag to enable debug information
    
  properties
    s
    in1
    in2
    in3
    name
    debug
    tau
  end
  
  methods
    function obj = am_multi3(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.in1 = 0;
    obj.in2 = 0;
    obj.in3 = 0;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if ~isempty(x)
      if isfield(x, "in1")
          obj.in1 = x.in1;
      end
      if isfield(x, "in2")
          obj.in2 = x.in2;
      end
      if isfield(x, "in3")
          obj.in3 = x.in3;
      end
    end
    end
                  
    function y = lambda(obj,e,x)
    in1 = obj.in1;  
    in2 = obj.in2;
    in3 = obj.in3;
    if ~isempty(x)
      if isfield(x, "in1")
          in1 = x.in1;
      end
      if isfield(x, "in2")
          in2 = x.in2;
      end
      if isfield(x, "in3")
          in3 = x.in3;
      end
    end
    
      y.out = in1 * in2 * in3;

    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
  end
end
