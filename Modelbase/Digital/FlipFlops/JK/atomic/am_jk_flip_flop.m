classdef am_jk_flip_flop < handle
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
%  q: current state of the flipflop
%% System Parameters
%  name:  object name
%  q0:    initial state
%  debug: model debug level
%  tau:   input delay
  
  properties
    s
    j
    clk
    k
    q
    name
    debug
    tau
  end
  
  methods
    function obj = am_jk_flip_flop(name, q0, tau, debug)
      obj.s = "running";
      obj.j = "U";
      obj.k = "U";
      obj.clk = "U";
      obj.q = q0;
      obj.name = name;
      obj.tau = tau;
      obj.debug = debug;
    end
        
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end
     
      if isfield(x, "clk")
        if x.clk == "1" && obj.clk == "0"  % rising edge
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
      if isfield(x, "clk") && x.clk == "1" && obj.clk == "0"  % rising edge
        y.q = getNewState(obj);
        y.qb = ieee1164_not(y.q);
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
        q = ieee1164_or(ieee1164_and(obj.j, ieee1164_not(obj.q)), ieee1164_and(ieee1164_not(obj.k), obj.q));
      %q = ((obj.j || obj.q) && ~obj.k) || (obj.j && obj.k && ~obj.q);
    end
    
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s j=%1d k=%1d clk=%1d q=%1d\n", ...
               obj.s, obj.j, obj.k, obj.clk, obj.q);
    end

  end
end
