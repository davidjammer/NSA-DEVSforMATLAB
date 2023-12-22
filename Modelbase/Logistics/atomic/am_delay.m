classdef am_delay < handle
  %% Description
  %  Delays the input entities by a constant amount.
  %% Ports
  %  inputs:
  %    in    incoming entities
  %  outputs:
  %    out   delayed entities
  %% States
  %  s:  running
  %  E:  waiting input values, E(i).x = value, E(i).e = remaining waiting time
  %% System Parameters
  %  name:  object name
  %  dt:    delay time
  %  tau:   infinitesimal delay
  %  debug: flag to enable debug information

  properties
    s
    E
    dt
    name
    tau
    debug
  end

  methods
    function obj = am_delay(name, dt, tau, debug)
      s = "running";
      obj.E = [];
      obj.name = name;
      obj.dt = dt;
      obj.tau = tau;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta, ", obj.name)
        if ~isempty(x)
          fprintf("in=%5.1f ", x.in)
        end
        showState(obj);
      end

      if isempty(x) && tIsNegative(obj.E(1).e - e)
        obj.E = obj.E(2:end);
      else
        if ~isempty(obj.E)
          for i=1:length(obj.E)
            obj.E(i).e = obj.E(i).e - e;  % adjust waiting times
          end
          if tIsNegative(obj.E(1).e)      % first element has been sent
            obj.E = obj.E(2:end); 
          end
        end
        if isfield(x,"in")                % append new element
          value.x = x.in;
          value.e = obj.dt;
          obj.E = [obj.E, value];
        end
      end

      if obj.debug
        fprintf("%-8s leaving  delta,", obj.name)
        showState(obj);
      end
    end

    function y = lambda(obj,e,x)
      if ~isempty(obj.E) && tIsNegative(obj.E(1).e - e)
        y.out = obj.E(1).x;
      else
        y = [];
      end

      if obj.debug
        fprintf("%-8s leaving lambda, ", obj.name)
        if isfield(y, "out")
          fprintf("out=%5.1f ", y.out)
        end
        fprintf("\n")
      end
    end

    function t = ta(obj)
      if isempty(obj.E)
        t = [Inf, 0];
      else
        t = obj.E(1).e;
      end

      if obj.debug
        fprintf("%-8s leaving ta    , ", obj.name)
        fprintf("t=[%4.1f,%4.1f]\n", t)
      end
    end

    function showState(obj)
      % debug function, prints current state
      n = length(obj.E);
      fprintf("  n=%1d E=", n);
      for I = 1:n
        E = obj.E(I);
        fprintf("([%4.1f,%4.1f], %4.1f) ", E.e(1), E.e(2), E.x);
      end
      fprintf("\n")
    end

  end
end
