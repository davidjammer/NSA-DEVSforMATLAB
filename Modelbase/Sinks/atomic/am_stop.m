classdef am_stop < handle
  %  Terminates simulation when input is true.
  %% Ports
  %  inputs:
  %    in       incoming value
  %% States
  %  s:        running
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    name
    tau
    debug
  end

  methods
    function obj = am_stop(name, tau, debug)
      obj.name = name;
      obj.s = "idle";
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in\n", obj.name)
      end
      if isstruct(x) && isfield(x,"in") && x.in == "1"
        stop_simulation();
      end
    end

    function y=lambda(obj,e,x)
      y=[];
    end

    function t = ta(obj)
      t = [Inf,0];
    end

  end
end
