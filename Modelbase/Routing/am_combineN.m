classdef am_combineN < handle
  %% Description
  %  combines entities from N inputs into one output
  %% Ports
  %  inputs:
  %    in1 ... inN  incoming entities
  %  outputs:
  %    out          outgoing entities
  %% States
  %  s: idle|go
  %  q: vector of arrived entities
  %% System Parameters
  %  name:  object name
  %  N:     number of input values
  %  tD:    delay time of the go state
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    q
    name
    N
    tD
    debug
    tau
  end

  methods
    function obj = am_combineN(name, N, tD, tau, debug)
      obj.s ="idle";
      obj.q = [];
      obj.name = name;
      obj.N = N;
      obj.tD = tD;
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
        for I=1:length(idx)
          if isempty(obj.q)
            obj.q = val(I);   % strange problem with type of []
          else
            obj.q(I) = val(I);
          end
        end
      end

      switch obj.s
        case "go"
          if isscalar(obj.q)
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
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
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

    %-------------------------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s q=", obj.s)
      if isempty(obj.q)
        fprintf("[] ");
      else
        fprintf("[ ");
        for I = 1:length(obj.q)-1
          fprintf("%s, ", getDescription(obj.q(I)));
        end
        fprintf("%s]", getDescription(obj.q(end)));
      end
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
        fprintf("out=%s\n", getDescription(y.out));
      else
        fprintf("\n")
      end
    end

  end
end
