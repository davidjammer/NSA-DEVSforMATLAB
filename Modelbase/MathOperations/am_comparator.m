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
  %  compop: compare operation
  %% System Parameters
  %  name:  object name
  %  compop: compare operation (<,>,<=,>=,==,~=)
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    name
    in1
    in2
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
      in1 = obj.in1;
      in2 = obj.in2;
      if ~isempty(x)
        if isfield(x, "in1")
          in1 = x.in1;
        end
        if isfield(x, "in2")
          in2 = x.in2;
        end
      end
      switch obj.compop
        case ">"
          y.out = (in1 > in2);
        case "<"
          y.out = (in1 < in2);
        case ">="
          y.out = (in1 >= in2);
        case "<="
          y.out = (in1 <= in2);
        case "=="
          y.out = (in1 == in2);
        case "~="
          y.out = (in1 ~= in2);
      end

      if obj.debug
        fprintf("%-8s lambda, in=%2d, out=%2d\n", obj.name, x.in, y.out);
      end
    end

    function t = ta(obj)
      t = [inf,0];
    end
  end
end
