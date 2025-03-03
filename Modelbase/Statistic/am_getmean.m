classdef am_getmean < handle
  %% Description
  %  Calculates the mean value of its input values.
  %% Ports
  %  inputs:
  %    in    numeric values
  %  outputs:
  %    out   arithmetic mean of input values
  %% States
  %  s:      running
  %  N:      number of input values
  %  sumIn:  sum of input values
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    N
    sumIn
    name
    tau
    debug
  end

  methods
    function obj = am_getmean(name, tau, debug)
      obj.s = "running";
      obj.N = 0;
      obj.sumIn = 0;
      obj.name = name;
      obj.tau = tau;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      if ~isempty(x) && isfield(x, "in") && isnumeric(x.in)
        obj.N = obj.N + 1;
        obj.sumIn = obj.sumIn + x.in;
      end
    end

    function y = lambda(obj,e,x)
      if ~isempty(x) && isfield(x, "in") && isnumeric(x.in)
        y.out = (obj.sumIn + x.in)/(obj.N + 1);
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
