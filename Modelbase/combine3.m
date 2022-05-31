classdef combine3 < handle
%% Description
%  combines entities from three inputs into one output
%% Ports
%  inputs: 
%    in1, in2, in3   incoming entities
%  outputs: 
%    out      outgoing entities
%% States
%  s: idle|go
%  q: vector of arrived entities
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:     infinitesimal delay
    
  properties
    s
    q
    name
    debug
    tau
  end
  
  methods
    function obj = combine3(name, tau, debug)
      obj.s ="idle"; 
      obj.q = [];
      obj.name = name;
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
      if isfield(x, "in3")
        obj.q = [obj.q, x.in3];
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
    end
 
    function t = ta(obj)
      switch obj.s
        case "idle"
          t = [inf, 0];
        case "go"
          t = obj.tau;
        otherwise
          fprintf("wrong phase %s in %s\n", obj.s, obj.name);
      end
    end
        
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s q=", obj.s)
      fprintf("%2d ", obj.q)
      fprintf("\n")
    end

  end
end
