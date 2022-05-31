classdef jkflipflop < handle
%% Description
%  JK flipflop with negative triggering
%% Ports
%  inputs: 
%    j, k, clk
%  outputs: 
%    q, qb
%% States
%  s: running
%  j, k, clk: store inputs
%  q: actual state of the flipflop
%% System Parameters
%  q0: initial state
%  name:  object name
%  debug: model debug level
%  tau:     infinitesimal delay
  
  properties
    s
    j
    clk
    k
    q
    q0
    name
    debug
    tau
  end
  
  methods
    function obj = jkflipflop(name, q0, tau, debug)
      obj.s = "running";
      obj.j = 0;
      obj.k = 0;
      obj.clk = 0;
      obj.q = q0;
      obj.name = name;
      obj.q0 = q0;
      obj.tau = tau;
      obj.debug = debug;
    end
        
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end
     
      if isfield(x, "clk")
        if x.clk == 0 && obj.clk == 1  % falling edge
          obj.q = getNewState(obj);
        end
        obj.clk = x.clk;
      end
      if isfield(x, "j")
        obj.j = x.j;
      end
      if isfield(x, "k")
        obj.k = x.k;
      end
      
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj);
      end
    end
    
    function y = lambda(obj, e, x)
      y = [];
      if isfield(x, "clk") && x.clk == 0 && obj.clk == 1  % falling edge
        y.q = getNewState(obj);
        y.qb = 1 - y.q;
      end

      if obj.debug && isfield(y, "q")
        fprintf("%-8s OUT, q=%1d\n", obj.name, y.q)
      end
    end

    function t = ta(obj)
      t = inf;
    end

    function q = getNewState(obj)
      % computes new state value
      q = ((obj.j || obj.q) && ~obj.k) || (obj.j && obj.k && ~obj.q);
    end
    
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s j=%1d k=%1d clk=%1d q=%1d\n", ...
               obj.s, obj.j, obj.k, obj.clk, obj.q);
    end

  end
end
