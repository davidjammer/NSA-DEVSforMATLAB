classdef heat_controller < handle
  %% Description
  %  Distributes heating signals according to phase.
  %% Ports
  %  inputs:
  %    phase: {load, heatup, hold, unload}
  %  outputs:
  %    full_heating
  %    holding_to
  %    unload
  %% States
  %
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:     infinitesimal delay

  properties
    s
    phase
    name
    debug
    tau
  end

  methods
    function obj = heat_controller(name, tau, debug)
      obj.s = "running";
      obj.name = name;
      obj.phase = [];
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if ~isempty(x) && isfield(x, "phase")
        obj.phase = x.phase;
      end
    end

    function y = lambda(obj,e,x)
      p = obj.phase;
      if ~isempty(x) && isfield(x, "phase")
        p = x.phase;
      end

      if p == "load"
        y.full_heating = 0;
        y.holding_to = 0;
        y.unload = 0;
      elseif p == "unload"
        y.full_heating = 0;
        y.holding_to = 0;
        y.unload = 1;
      elseif p == "heatup"
        y.full_heating = 1;
        y.holding_to = 0;
        y.unload = 0;
      elseif p == "hold"
        y.full_heating = 0;
        y.holding_to = 1;
        y.unload = 0;
      else
        y = [];
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
