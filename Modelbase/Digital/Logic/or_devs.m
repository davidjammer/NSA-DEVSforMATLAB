classdef or_devs < handle
%% Description
%  simple or gate
%% Ports
%  inputs: 
%    in1, in2 incoming values
%  outputs: 
%    out      output value
%% States
%  s: {}
%  i1,i2 input values
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  r:     infinitesimal delay

  properties
    s
    name
    debug
    tau
    i1
    i2
  end
    
  methods
    function obj = or_devs(name, tau, debug, in1,in2)
      obj.s = "running";
      
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
	 if nargin == 5
		obj.i1 = in1;
		obj.i2 = in2;
	 else
		obj.i1 = [];
          obj.i2 = [];
	 end
    end
        
    function delta(obj,e,x)
      
      if isfield(x, "in1")
        obj.i1 = x.in1;
      end
      if isfield(x, "in2")
        obj.i2 = x.in2;
	 end
    end
    
    function y = lambda(obj,e,x)
      s1 = obj.i1;
      s2 = obj.i2;
      if isfield(x, "in1")
        s1 = x.in1;
      end
      if isfield(x, "in2")
        s2 = x.in2;
	 end
	 
	 if ~isempty(s1) && ~isempty(s2)
		y.out = s1 | s2;
	 else
		y = [];
	 end
	 
    end    
       
    function t = ta(obj)
        t = [inf, 0];
    end
  end
end
