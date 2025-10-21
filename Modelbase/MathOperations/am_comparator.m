classdef am_comparator < handle
  %% Description
  %  returns 1 if in1 (compare operation) in2, else 0
  %% Ports
  %  inputs:
  %    in1, in2    incoming value
  %  outputs:
  %    out      1 if in1 (compare operation) in2, else 0
  %% States
  %  s:   running
  %  in1/2: current input values
  %% System Parameters
  %  name:  object name
  %  compop: compare operation (<,>,<=,>=,==,~=)
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    in1
    in2
    name
    compop
    debug
    tau
  end

  methods
    function obj = am_comparator(name, compop, tau, debug)
      obj.s ="running";
      obj.name = name;
      obj.compop = compop;
      obj.in1 = 0;
      obj.in2 = 0;
      obj.tau = tau;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      if ~isempty(x)
        if isfield(x, "in1")
          obj.in1 = x.in1;
        end
        if isfield(x, "in2")
          obj.in2 = x.in2;
        end
      end
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end
    end

    function y = lambda(obj,e,x)
      i1 = obj.in1;
      i2 = obj.in2;
      if ~isempty(x)
        if isfield(x, "in1")
          i1 = x.in1;
        end
        if isfield(x, "in2")
          i2 = x.in2;
        end
      end
      switch obj.compop
        case ">"
          y.out = (i1 > i2);
        case "<"
          y.out = (i1 < i2);
        case ">="
          y.out = (i1 >= i2);
        case "<="
          y.out = (i1 <= i2);
        case "=="
          y.out = (i1 == i2);
        case "~="
          y.out = (i1 ~= i2);
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      t = [inf,0];
    end
    %-------------------------------------------------------

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  input:  %s\n", getDescription(x))
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf("  output: %s\n", getDescription(y))
    end
  end
end
