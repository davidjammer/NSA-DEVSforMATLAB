classdef am_smallestinN < handle
  %% Description
  %  outputs index of smallest input value among N inputs
  %% Ports
  %  inputs:
  %    in1 ... inN  incoming values
  %  outputs:
  %    out          index of smallest input
  %% States
  %  s: running
  %  n: vector of arrived values
  %% System Parameters
  %  name:  object name
  %  N:     number of input values
  %  val0:  initial output index
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    n
    name
    N
    val0
    debug
    tau
  end

  methods
    function obj = am_smallestinN(name, N, val0, tau, debug)
      obj.s = "running";
      obj.n = zeros(N,1);
      obj.name = name;
      obj.N = N;
      obj.val0 = val0;
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
        obj.n(idx) = val;
      else
        fprintf("%s, - wrong input %s\n", obj.name, getDescription(x.in))
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      ns = obj.n;
      [idx, val] = splitInput(x);
      if max(idx) <= obj.N
        ns(idx) = val;
      else
        fprintf("%s, - wrong input %s\n", obj.name, getDescription(x.in))
      end
      [~, y.out] = min(ns);
      
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
      fprintf("  phase=%s n=[", obj.s)
      for I=1:obj.N-1
        fprintf("%.2f, ", obj.n(I))
      end
      fprintf("%.2f]", obj.n(end))
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
        fprintf("out=%d", y.out);
      end
      fprintf("\n")
    end

  end
end
