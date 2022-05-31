classdef queue < handle
%% Description
%  FIFO queue with output of current queue length
%% Ports
%  inputs: 
%    in   incoming entities
%    bl   blocking status of output
%  outputs: 
%    out  outgoing entities
%    nq   queue length
%% States
%  s: emptyFree|emptyBlocked|queuingFree|queuingBlocked
%  q: vector of queued entities
%% System Parameters
%  name:  object name
%  tau:   infinitesimal delay
%  tD:    delay time of the queuingBlocked state
%  debug: model debug level
%  epsilon: assumed accuracy of time values
%
  properties
    s
    q
    name
    tau
    tD
    debug
    epsilon
  end
  
  methods
    function obj = queue(name, tau, debug, tD)
      obj.s = "emptyFree";
      obj.q = [];
      obj.name = name;
      obj.debug = debug;
      obj.epsilon = get_epsilon();
      obj.tau = tau;
      
      if nargin == 3
        obj.tD = [0,1];
      else
        obj.tD = tD;
      end
    end
    
		function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta,", obj.name)
        showState(obj);
      end
      
      [bl, in] = readInputBag(obj, x);

      switch obj.s
        case "emptyFree"
          if ~isempty(bl) && bl == true && isempty(in)
            obj.s = "emptyBlocked";
          elseif ~isempty(bl) && bl == true && ~isempty(in)
            obj.s = "queuingBlocked";
            obj.q = [obj.q, in];
          elseif ~isempty(in)
            obj.s = "queuingFree";
            obj.q = [obj.q, in];
          else
            % no entities, bl status remains
          end
        case "emptyBlocked"
          if ~isempty(bl) && bl == false && isempty(in)
            obj.s = "emptyFree";
          elseif ~isempty(bl) && bl == false && ~isempty(in)
            obj.s = "queuingFree";
            obj.q = [obj.q, in];
          elseif ~isempty(in)
            obj.s = "queuingBlocked";
            obj.q = [obj.q, in];
          else
            % no entities, bl status remains
          end
        case "queuingFree"
          if isempty(x)     % internal event
            if (length(obj.q) == 1) 
              obj.s = "emptyFree";
            else
              obj.s = "queuingFree";
            end
            obj.q = obj.q(2:end);
          else             % confluent event
            if (bl == true)
              % blocking has precedence, no entity leaves!
              obj.s = "queuingBlocked";
              obj.q = [obj.q, in];
            else
              obj.q = [obj.q(2:end), in];
              if isempty(obj.q)
                obj.s = "emptyFree";
              else
                obj.s = "queuingFree";
              end
            end
          end
        case "queuingBlocked"
          obj.q = [obj.q, in];
          if bl == false
            obj.s = "queuingFree";
          else
            obj.s = "queuingBlocked";
          end
      end
      
      if obj.debug
        fprintf("%-8s leaving  delta,", obj.name)
        showState(obj);
      end      
    end
    
    function y = lambda(obj,e,x)
      y = [];     % necessary dummy value for no-op
      [bl, in] = readInputBag(obj, x);
      nIn = length(in);
      
      if obj.s == "queuingFree"
        if bl == true
          y.nq = length(obj.q) + nIn;
          %y.out = [];   % leads to errors!
        else
          y.out = obj.q(1);
          y.nq = length(obj.q) + nIn - 1;
        end
      else
        y.nq = length(obj.q) + nIn;
        %y.out = [];   % leads to errors!
      end
  
      if obj.debug
        fprintf("%-8s lambda, ", obj.name)
        if isfield(y, "nq")
          fprintf("nq=%2d ", y.nq)
        end
        if isfield(y, "out")
          fprintf("out=%2d\n", y.out)
        end
        fprintf("\n")
      end
    end
    
    function t = ta(obj)
      switch obj.s
        case {"emptyFree", "emptyBlocked", "queuingBlocked"}
          t = [Inf,0];
        case "queuingFree"
          t = obj.tD;
      end
    end
    
    %-------------------------------------------------------
    function [bl, in] = readInputBag(obj, x)
      % returns input values of bl and in
      % value = [], if there is no input at a port
      if isfield(x, "bl")
        bl = x.bl;
      else
        bl = [];
      end

      if isfield(x, "in")
        in = x.in;
      else
        in = [];
      end 
    end
    
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%8s n=%1d queue=", obj.s, length(obj.q))
      fprintf("%2d ", obj.q)
      fprintf("\n")
    end
    
  end
end
