classdef multi2 < handle
  %% Description
  %  multiplies in1 with in2
  %% Ports
  %  inputs:
  %    in1, in2  incoming values
  %  outputs:
  %    out       product of input values
  %% States
  %  s:     running
  %  in1/2: current input values
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    in1
    in2
    name
    tau
    debug
  end

  methods
    function obj = multi2(name, tau, debug)
      obj.s ="running";
      obj.name = name;
      obj.in1 = 0;
      obj.in2 = 0;
      obj.debug = debug;
      obj.tau = tau;
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

      y.out = in1 * in2;

    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
