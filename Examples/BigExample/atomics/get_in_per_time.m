classdef get_in_per_time < handle
  %% Description
  %  returns input/(current running time)
  %  use with in = "number of arrived entities"
  %     -> out = "mean processing time per entity"
  %% Ports
  %  inputs:
  %    in       e.g. number of arrived entities
  %  outputs:
  %    out      in / (current running time)
  %% States
  %  s:   running
  %  t:   current running time 
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    t
    name
    tau
    debug
  end

  methods
    function obj = get_in_per_time(name, tau, debug)
      obj.s ="running";
      obj.name = name;
      obj.t = 0;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      obj.t = obj.t + e(1);
    end

    function y = lambda(obj,e,x)
      if ~isempty(x) && isfield(x, "in")
        n = x.in;
        totaltime = obj.t + e(1);
        y.out = totaltime / n;
      else
        y = [];
      end

    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
