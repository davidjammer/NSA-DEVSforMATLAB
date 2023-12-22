classdef am_vectorgen < handle
%% Description
%  generates given fixed output values at given times
%  repeats cyclically
%% Ports
%  inputs: none
%  outputs: 
%    out      given values
%% States
%  s          running
%  index      index of next value 
%% System Parameters
%  tVec:  vector of output times 
%  yVec:  vector of output values 
%  name:  object name
%  tau:   input delay
%  debug: flag to enable debug information

  properties
    s
    index
    name
    tVec
    yVec
    debug
    epsilon
    tau
  end
  
  methods
    function obj = am_vectorgen(name, tVec, yVec, tau, debug)
      obj.s = "running"; 
      obj.index = 1;
      obj.name = name;
      obj.tVec = tVec;
      obj.yVec = yVec;
      obj.debug = debug;
      obj.epsilon = get_epsilon();
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in, index=%2d\n", obj.name, obj.index)
      end
      
      obj.index = mod(obj.index, length(obj.tVec)) + 1;

      if obj.debug
        fprintf("%-8s delta out, index=%2d\n", obj.name, obj.index)
      end
    end
               
     function y = lambda(obj,e,x)
      y.out = obj.yVec(obj.index);

      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out);
      end
    end

    function t = ta(obj)
      if obj.index == 1
        t = [obj.tVec(1), 0];
      else
        t = [obj.tVec(obj.index) - obj.tVec(obj.index - 1), 0];
      end
    end
    
  end
end
