classdef am_generator < handle
%% Description
%  generates entities with fixed interarrival times
%% Ports
%  inputs: none
%  outputs: 
%    out      generated entities
%% States
%  s:  prod  (fix)  
%  id: number of workpieces generated
%% System Parameters
%  tG:    time interval between new entities
%  n0:    id of first entity
%  nG:    total number of entities created
%  name:  object name
%  tau:   input delay
%  debug: flag to enable debug information

  properties
    tau
    s
    id
    name
    tG
    n0
    nG
    debug
    epsilon
  end
  
  methods
    function obj = am_generator(name, tG, n0, nG, tau, debug)
      obj.name = name;
      obj.tG = tG;
      obj.n0 = n0;
      obj.nG = nG;
      obj.debug = debug;
      obj.s = "prod";
      obj.id = n0;
      obj.epsilon = get_epsilon();
      obj.tau = tau;
    end
    
    function delta(obj,e,x)
      tr = ta(obj);
     	if abs(e(1) - tr(1)) <= obj.epsilon
        obj.s = "prod";  
        obj.id = obj.id + 1;
      end
    end
       
    function y = lambda(obj,e,x)
      tr = ta(obj);
      if abs(e(1) - tr(1)) <= obj.epsilon
        y.out = obj.id;
      end
      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end
    end
    
    function t = ta(obj)
      if obj.id - obj.n0 < obj.nG 
        if obj.tG == 0
          t = obj.tau;
        else
          t = [obj.tG, 0];
        end
      else
        t = [inf, 0];
      end
    end
    
  end   
end