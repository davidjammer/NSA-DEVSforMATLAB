classdef bingenerator < handle
%% Description
%  generates binary output values at given times
%  changes output at each given time
%  repeats cyclically
%% Ports
%  inputs: none
%  outputs: 
%    out      next binary value
%% States
%  s          running
%  z          internal state
%  index      index of next time value
%% System Parameters
%  z0:    initial state
%  tVec:  vector of output times 
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay

  properties
    s
    z
    index
    z0
    tVec
    name
    debug
    tau
  end
  
  methods
    function obj = bingenerator(name, z0, tVec, tau, debug)
      obj.z = z0;
      obj.index = 0;
      obj.name = name;
      obj.s = "running";
      obj.z0 = z0;
      obj.tVec = tVec;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj, e, x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end
           
      obj.index = mod(obj.index, length(obj.tVec)) + 1;
      obj.z = ~obj.z;
      
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
                     
    function y = lambda(obj, e, x)
      y.out = obj.z;

      if obj.debug
        fprintf("%-8s OUT, out=%2d\n", obj.name, y.out);
      end
    end

    function t = ta(obj)
      if obj.index == 0
        t = 0;     % output initial value
      elseif obj.index == 1
        t = obj.tVec(1);
      else
        t = obj.tVec(obj.index) ...
               - obj.tVec(obj.index - 1);
      end
      if obj.debug
        fprintf("%-8s TA, ta=%2d\n", obj.name, t);
      end
    end
    
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s index=%d z=%2d\n", obj.s, obj.index, obj.z);
    end
   
  end
end
