classdef set_time < handle
  %% Description
  %
  %% Ports
  %  inputs:
  %    in
  %  outputs:
  %    out
  %% States
  %  t
  %  field
  %  s:   running
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    t
    field
    name
    debug
    tau
  end

  methods
    function obj = set_time(name, field, tau, debug)
      obj.s ="running";
      obj.name = name;
      obj.t = 0;
      obj.debug = debug;
      obj.tau = tau;
      obj.field = field;
    end

    function delta(obj,e,x)
      obj.t = obj.t + e(1);
    end

    function y = lambda(obj,e,x)
      if ~isempty(x) && isfield(x, "in")
        E = x.in;
        E.(obj.field) = obj.t + e(1);
        y.out = E;
      else
        y = [];
      end

    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
