classdef furnace_controller < handle
  %% Description
  % Sequence controller of a furnace.
  %% Ports
  %  inputs:
  %    entered
  %    heatupready
  %  outputs:
  %    phase
  %    leaving
  %    Tset
  %% States
  %  s:       load, heatup, hold, unload
  %  sigma:   time until next state change
  %  epsilon: accuracy of real number comparisons
  %% System Parameters
  %  name:         object name
  %  holding_time: duration of holding phase
  %  Tsoll:        temperature setpoint
  %  tau:          infinitesimal delay
  %  debug:        flag to enable debug information

  properties
    s
    holding_time
    Tsoll
    name
    debug
    tau
    sigma
    epsilon
  end

  methods
    function obj = furnace_controller(name, holding_time, Tsoll, tau, debug)
      obj.s = "load";
      obj.holding_time = holding_time;
      obj.Tsoll = Tsoll;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
      obj.sigma = inf;
      obj.epsilon = get_epsilon();
    end

    function delta(obj,e,x)

      if obj.s == "load"
        if ~isempty(x) && isfield(x, "entered") && x.entered == "1"
          obj.s = "heatup";
          obj.sigma = inf;
        end
      elseif obj.s == "heatup"
        if ~isempty(x) && isfield(x, "heatupready") && x.heatupready == "1"
          obj.s = "hold";
          obj.sigma = obj.holding_time;
        end
      elseif obj.s == "hold"
        if obj.sigma == e(1)
          obj.s = "unload";
          obj.sigma = 50;
        else
          obj.sigma = obj.sigma - e(1);
          if obj.sigma < obj.epsilon
            obj.sigma = 0;
          end
        end
      elseif obj.s == "unload"
        if obj.sigma == e(1)
          obj.s = "load";
          obj.sigma = inf;
        else
          obj.sigma = obj.sigma - e(1);
          if obj.sigma < obj.epsilon
            obj.sigma = 0;
          end
        end
      end
    end

    function y = lambda(obj,e,x)
      y = [];

      if obj.s == "load"
        if ~isempty(x) && isfield(x, "entered") && x.entered == "1"
          y.phase = "heatup";
          y.Tset = obj.Tsoll;
        end
      elseif obj.s == "heatup"
        if ~isempty(x) && isfield(x, "heatupready") && x.heatupready == "1"
          y.phase = "hold";
        end
      elseif obj.s == "hold"
        if obj.sigma == e(1)
          y.phase = "unload";
        end
      elseif obj.s == "unload"
        if obj.sigma == e(1)
          y.phase = "load";
          y.leaving = "1";
        end
      end

    end

    function t = ta(obj)
      t = [obj.sigma, 0];
    end

  end
end
