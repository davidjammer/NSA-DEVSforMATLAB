classdef am_generator < handle
%% Description
%  generates entities with fixed interarrival times and increasing id's
%% Ports
%  inputs: none
%  outputs: 
%    out  generated entities
%% States
%  s:       running
%  id:      number of next entity generated
%  epsilon: accuracy of real number comparisons
%% System Parameters
%  name:  object name
%  tG:    time interval between new entities
%  n0:    id of first entity
%  nG:    total number of entities created
%  tD:    delay between entities, when tG = 0
%  debug: flag to enable debug information

  properties
    s
    id
    epsilon
    name
    tG
    n0
    nG
    tD
    debug
  end
  
  methods
    function obj = am_generator(name, tG, n0, nG, tD, debug)
      obj.name = name;
      obj.tG = tG;
      obj.n0 = n0;
      obj.nG = nG;
      obj.debug = debug;
      obj.s = "running";
      obj.id = n0;
      obj.epsilon = get_epsilon();
      obj.tD = tD;
    end
    
    function delta(obj,e,x)
      tr = ta(obj);
     	if abs(e(1) - tr(1)) <= obj.epsilon
        obj.id = obj.id + 1;
      end
    end
       
    function y = lambda(obj,e,x)
      tr = ta(obj);
      if abs(e(1) - tr(1)) <= obj.epsilon
        y.out = obj.id;
      end
      if obj.debug
        fprintf("%-8s lambda\n  out: %2d\n", obj.name, y.out)
      end
    end
    
    function t = ta(obj)
      if obj.id - obj.n0 < obj.nG 
        if obj.tG == 0
          t = obj.tD;
        else
          t = [obj.tG, 0];
        end
      else
        t = [inf, 0];
      end
    end
    
  end   
end