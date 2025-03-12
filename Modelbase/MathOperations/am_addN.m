classdef am_addN < handle
  %% Description
  %  adds N inputs
  %% Ports
  %  inputs:
  %    in1 .. inN   incoming values
  %  outputs:
  %    out          sum of input values
  %% States
  %  s: running
  %  u: vector of current input values
  %% System Parameters
  %  name:  object name
  %  N:     number of input values
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    u
    name
    N
    debug
    tau
  end

  methods
    function obj = am_addN(name, N, tau, debug)
      obj.s = "running";
      obj.u = zeros(N, 1);
      obj.name = name;
      obj.N = N;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      [idx, val] = splitInput(x);
      if max(idx) <= obj.N
        obj.u(idx) = val;
      else
        fprintf("%s, - wrong input %s\n", obj.name, getDescription(x.in))
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      us = obj.u;
      [idx, val] = splitInput(x);
      if max(idx) <= obj.N
        us(idx) = val;
      else
        fprintf("%s, - wrong input %s\n", obj.name, getDescription(x.in))
      end
      y.out = sum(us);

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

    %-------------------------------------------------------------------------   
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s u=[", obj.s)
      for I=1:obj.N-1
        fprintf("%.2f, ", obj.u(I))
      end
      fprintf("%.2f]", obj.u(end))
      fprintf("\n")
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      [idx, val] = splitInput(x);
      for I=1:length(idx)
        fprintf("in%d=%.2f ", idx(I), val(I));
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "out")
        fprintf("out=%.2f", y.out);
      end
      fprintf("\n")
    end

  end
end
