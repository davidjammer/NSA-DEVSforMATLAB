classdef am_max2 < handle
  %% Description
  %  outputs maximal value of two inputs
  %% Ports
  %  inputs:
  %    in1, in2 incoming values
  %  outputs:
  %    out      max of input values
  %% States
  %  s:        running
  %  u1,u2:  current input values
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    u1
    u2
    name
    tau
    debug
  end

  methods
    function obj = am_max2(name, tau, debug)
      obj.s = "running";
      obj.u1 = -Inf;
      obj.u2 = -Inf;
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
        obj.u1 = x.in1;
      end
      if isfield(x, "in2")
        obj.u2 = x.in2;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.u1;
      s2 = obj.u2;
      if isfield(x, "in1")
        s1 = x.in1;
      end
      if isfield(x, "in2")
        s2 = x.in2;
      end
      y.out = max(s1, s2);

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      t = [Inf, 0];
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%4s in1=%4.2f in2=%4.2f\n", obj.s, obj.u1, obj.u2)
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in1")
        fprintf("in1=%4.2f ", x.in1);
      end
      if isfield(x, "in2")
        fprintf("in2=%4.2f", x.in2);
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "out")
        fprintf("%4.2f", y.out);
      end
      fprintf("\n")
    end
  end
end
