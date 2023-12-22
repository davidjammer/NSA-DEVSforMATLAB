classdef checkTemperature < handle
  %% Description
  %  checks if heatup phase is ready
  %% Ports
  %  inputs:
  %    phase: {load, heatup, hold, unload}
  %    T
  %    Tset
  %  outputs:
  %    heatupready
  %% States
  %  s:       running
  %  phase:   current phase of furnace
  %  T:       current temperature
  %  Tset:    set point of temperature
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:     infinitesimal delay

  properties
    s
    phase
    T
    Tset
    name
    debug
    tau
  end

  methods
    function obj = checkTemperature(name, tau, debug)
      obj.s = "running";
      obj.name = name;
      obj.phase = "load";
      obj.T = 0;
      obj.Tset = 0;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if ~isempty(x) && isfield(x, "phase")
        obj.phase = x.phase;
      end
      if ~isempty(x) && isfield(x, "T")
        obj.T = x.T;
      end
      if ~isempty(x) && isfield(x, "Tset")
        obj.Tset = x.Tset;
      end
    end

    function y = lambda(obj,e,x)
      p = obj.phase;
      Tset = obj.Tset;
      T = obj.T;
      if ~isempty(x) && isfield(x, "phase")
        p = x.phase;
      end
      if ~isempty(x) && isfield(x, "T")
        T = x.T;
      end
      if ~isempty(x) && isfield(x, "Tset")
        Tset = x.Tset;
      end

      if p == "heatup"
        if T >= Tset
          y.heatupready = "1";
        else
          y.heatupready = "0";
        end
      else
        y=[];
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
