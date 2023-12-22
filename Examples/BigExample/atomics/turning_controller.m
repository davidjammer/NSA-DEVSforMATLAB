classdef turning_controller < handle
  %% Description
  %  Sequence controller of a turning machine.
  %% Ports
  %  inputs:
  %    entered
  %    ap
  %    f
  %    vc
  %  outputs:
  %    on
  %    turning
  %    phase
  %    leaving
  %% States
  %  s:       idle, startup, turning, down, wait
  %  ap:      cutting depth
  %  f:       feed
  %  vc:      cutting speed
  %  sigma:   time until next state change
  %  epsilon: accuracy of real number comparisons
  %% System Parameters
  %  name:         object name
  %  turning_time:
  %  ap_ug:
  %  f_ug:
  %  vc_ug:
  %  ap_og:
  %  f_og:
  %  vc_og:
  %  tau:          infinitesimal delay
  %  debug:        flag to enable debug information

  properties
    s
    ap
    f
    vc
    ap_ug
    f_ug
    vc_ug
    ap_og
    f_og
    vc_og
    turning_time
    name
    debug
    tau
    sigma
    epsilon
  end

  methods
    function obj = turning_controller(name, turning_time, ap_ug, f_ug, ...
        vc_ug, ap_og, f_og, vc_og, tau, debug)
      obj.s = "idle";
      obj.name = name;
      obj.debug = debug;
      obj.turning_time = turning_time;
      obj.ap = ap_ug;
      obj.f = f_ug;
      obj.vc = vc_ug;
      obj.ap_ug = ap_ug;
      obj.f_ug = f_ug;
      obj.vc_ug = vc_ug;
      obj.ap_og = ap_og;
      obj.f_og = f_og;
      obj.vc_og = vc_og;
      obj.tau = tau;
      obj.sigma = inf;
      obj.epsilon = get_epsilon();
    end

    function delta(obj,e,x)

      if ~isempty(x)
        if isfield(x, "ap")
          obj.ap = x.ap;
        end
        if isfield(x, "f")
          obj.f = x.f;
        end
        if isfield(x, "vc")
          obj.vc = x.vc;
        end
      end

      if obj.s == "idle"
        if ~isempty(x) && isfield(x, "entered") && x.entered == "1"
          obj.s = "startup";
          obj.sigma = 20;
        end
      elseif obj.s == "startup"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          obj.s = "turning";
          obj.sigma = obj.turning_time ...
            - (obj.ap - obj.ap_ug) / (obj.ap_og - obj.ap_ug) * 50 ...
            - (obj.f - obj.f_ug) / (obj.f_og - obj.f_ug) * 70 ...
            - (obj.vc - obj.vc_ug) / (obj.vc_og - obj.vc_ug) * 100;
        end
      elseif obj.s == "turning"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          obj.s = "down";
          obj.sigma = 10;
        end
      elseif obj.s == "down"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          obj.s = "wait";
          obj.sigma = 30;
        end
      elseif obj.s == "wait"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          obj.s = "idle";
          obj.sigma = inf;
        end
      end
    end

    function y = lambda(obj,e,x)
      y = [];
      if obj.s == "idle"
        if ~isempty(x) && isfield(x, "entered") && x.entered == "1"
          y.on = 1;
          y.phase = "startup";
        end
      elseif obj.s == "startup"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.turning = 1;
          y.phase = "turning";
        end
      elseif obj.s == "turning"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.turning = 0;
          y.phase = "down";
        end
      elseif obj.s == "down"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.on = 0;
          y.phase = "wait";
        end
      elseif obj.s == "wait"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.leaving = "1";
          y.phase = "idle";
        end
      end
    end

    function t = ta(obj)
      t = [obj.sigma, 0];
    end

  end
end
