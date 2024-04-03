classdef am_combine2 < handle
%% Description
%  combines entities from two inputs into one output
%% Ports
%  inputs: 
%    in1, in2  incoming entities
%  outputs: 
%    out      outgoing entities
%% States
%  s: idle|go
%  q: vector of arrived entities
%% System Parameters
%  name:  object name
%  tD:    delay time of the go state
%  tau:   input delay
%  debug: flag to enable debug information
    
  properties
    s
    q
    name
    tD
    debug
    tau
  end
  
  methods
    function obj = am_combine2(name, tD, tau, debug)
      obj.s ="idle"; 
      obj.q = [];
      obj.name = name;
      obj.tD = tD;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end
      
      if isfield(x, "in1")
        obj.q = [obj.q, x.in1];
      end
      if isfield(x, "in2")
        obj.q = [obj.q, x.in2];
      end

      switch obj.s
        case "go"
          if length(obj.q) == 1
            obj.s = "idle";
          else
            obj.s = "go";
          end
          obj.q = obj.q(2:end);
        case "idle"
          if ~isempty(obj.q)
            obj.s = "go";
          end         
        otherwise
          fprintf("wrong phase %s in %s\n", obj.s, obj.name);
      end
      
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
   end
    
    function y = lambda(obj,e,x)
      y = [];
      if ~isempty(obj.q)
        y.out = obj.q(1);
      end
      
      if obj.debug
        fprintf("%-8s lambda, ", obj.name)
        if isfield(y, "out") 
          if isstruct(y.out) && isfield(y.out, "id")
            fprintf("out=%2d\n", y.out.id)
          else
            fprintf("out=%2d\n", y.out)
          end
        else
          fprintf("\n")
        end
      end      
    end
 
    function t = ta(obj)
      switch obj.s
        case "idle"
          t = [inf, 0];
        case "go"
          t = obj.tD;
        otherwise
          fprintf("wrong phase %s in %s\n", obj.s, obj.name);
      end
    end
        
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s q=", obj.s)
      if isstruct(obj.q) && isfield(obj.q, "id")
        fprintf("%2d ", obj.q.id)
      else
        fprintf("%2d ", obj.q)
      end
      fprintf("\n")
    end

  end
end