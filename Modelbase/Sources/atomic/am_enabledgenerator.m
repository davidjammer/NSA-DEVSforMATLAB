classdef am_enabledgenerator < handle
%% Description
%  generates entities with fixed interarrival times
%  stops, while enable input = false
%% Ports
%  inputs: 
%    enable   "1" -> generator runs
%  outputs: 
%    out      generated entities
%% States
%  s:     running|stopped
%  id:    number of next entity generated
%  sigma: time until next state change
%  epsilon: accuracy of real number comparisons
%% System Parameters
%  name:  object name
%  tG:    time interval between new entities
%  n0:    id of first entity
%  nG:    total number of entities created
%  tau:   input delay
%  debug: flag to enable debug information

  properties
    s
    id
    sigma
    epsilon
    name
    tG
    n0
    nG
    tau
    debug
  end
  
  methods
    function obj = am_enabledgenerator(name, tG, n0, nG, tau, debug)
      obj.name = name;
      obj.tG = tG;
      obj.n0 = n0;
      obj.nG = nG;
      obj.s = "running";
      obj.id = n0;
      obj.sigma = tG;
      obj.epsilon = get_epsilon();
      obj.tau = tau;
      obj.debug = debug;
    end
    
    function delta(obj,e,x)
      if ~isempty(x) && isfield(x, "enable") && x.enable == "0"
        obj.s = "stopped";
      elseif ~isempty(x) && isfield(x, "enable") && x.enable == "1" ...
                         && obj.s == "stopped"
        obj.s = "running";
      elseif abs(e(1) - obj.sigma) <= obj.epsilon
        obj.s = "running";
        obj.sigma = obj.tG;
        obj.id = obj.id + 1;
      else
        obj.sigma = obj.sigma - e(1);
      end
    end
       
    function y = lambda(obj,e,x)
      if ~isempty(x) && isfield(x, "enable") && x.enable == "0"
        y = [];
      elseif obj.s == "running" && abs(e(1) - obj.sigma) <= obj.epsilon
        y.out = obj.id;
      else
        y=[];
      end
   
      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end   
    end
    
    function t = ta(obj)
      if obj.id - obj.n0 < obj.nG && obj.s == "running"
        t = [obj.sigma, 0];
      else
        t = [inf, 0];
      end
    end
    
  end   
end