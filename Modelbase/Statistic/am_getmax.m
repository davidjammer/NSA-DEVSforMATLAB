classdef am_getmax < handle
  %% Description
  %  Outputs the maximum value of all incoming values.
  %% Ports
  %  inputs:
  %    in       incoming value
  %  outputs:
  %    out      maximum of input values
  %% States
  %  s:     running
  %  value: current max value
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    value
    name
    tau
    debug
  end

  methods
    function obj = am_getmax(name, tau, debug)
      obj.s ="running";
      obj.name = name;
      obj.value = 0;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if ~isempty(x) && isfield(x, "in") && obj.value < x.in
        obj.value = x.in;
      end
    end

    function y = lambda(obj,e,x)
      y = [];
      if ~isempty(x) && isfield(x, "in") && obj.value < x.in
        y.out = x.in;
      end

    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
