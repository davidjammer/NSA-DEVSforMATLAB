classdef grinding_controller < handle
  %% Description
  %  Sequence controller of a grinding machine.
  %% Ports
  %  inputs:
  %    entered
  %    vfr1
  %    vfr2
  %    vfr3
  %    vc
  %  outputs:
  %    on
  %    grinding
  %    phase
  %    leaving
  %% States
  %  s:        idle, startup, grinding, down, wait
  %  vfr1/2/3: 
  %  vc:       
  %  sigma:    time until next state change
  %  epsilon:  accuracy of real number comparisons
  %% System Parameters
  %  name:          object name
  %  grinding_time: 
  %  vfr1/2/3_ug:
  %  vc_ug:
  %  vfr1/2/3_og:
  %  vc_og:
  %  tau:           infinitesimal delay
  %  debug:         flag to enable debug information

  properties
    s
    vfr1
    vfr2
    vfr3
    vc
    sigma
    epsilon
    name
    grinding_time
    vfr1_ug
    vfr2_ug
    vfr3_ug
    vc_ug
    vfr1_og
    vfr2_og
    vfr3_og
    vc_og
    tau
    debug
  end

  methods
    function obj = grinding_controller(name, grinding_time, vfr1_ug, ...
        vfr2_ug, vfr3_ug, vc_ug, vfr1_og, vfr2_og, vfr3_og, vc_og, tau, debug)
      obj.s = "idle";
      obj.name = name;
      obj.debug = debug;
      obj.grinding_time = grinding_time;
      obj.vfr1 = vfr1_ug;
      obj.vfr2 = vfr2_ug;
      obj.vfr3 = vfr3_ug;
      obj.vc = vc_ug;
      obj.vfr1_ug = vfr1_ug;
      obj.vfr2_ug = vfr2_ug;
      obj.vfr3_ug = vfr3_ug;
      obj.vc_ug = vc_ug;
      obj.vfr1_og = vfr1_og;
      obj.vfr2_og = vfr2_og;
      obj.vfr3_og = vfr3_og;
      obj.vc_og = vc_og;
      obj.tau = tau;
      obj.sigma = inf;
      obj.epsilon = get_epsilon();
    end

    function delta(obj,e,x)

      if ~isempty(x)
        if isfield(x, "vfr1")
          obj.vfr1 = x.vfr1;
        end
        if isfield(x, "vfr2")
          obj.vfr2 = x.vfr2;
        end
        if isfield(x, "vfr3")
          obj.vfr3 = x.vfr3;
        end
        if isfield(x, "vc")
          obj.vc = x.vc;
        end
      end

      if obj.s == "idle"
        if ~isempty(x) && isfield(x, "entered") && x.entered == 1
          obj.s = "startup";
          obj.sigma = 20;
        end
      elseif obj.s == "startup"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          obj.s = "grinding";
          obj.sigma = obj.grinding_time ...
            - (obj.vfr1 - obj.vfr1_ug) / (obj.vfr1_og - obj.vfr1_ug) * 40 ...
            - (obj.vfr2 - obj.vfr2_ug) / (obj.vfr2_og - obj.vfr2_ug) * 40 ...
            - (obj.vfr3 - obj.vfr3_ug) / (obj.vfr3_og - obj.vfr3_ug) * 40 ...
            - (obj.vc - obj.vc_ug) / (obj.vc_og - obj.vc_ug) * 100;
        end
      elseif obj.s == "grinding"
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
        if ~isempty(x) && isfield(x, "entered") && x.entered == 1
          y.on = 1;
          y.phase = "startup";
        end
      elseif obj.s == "startup"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.grinding = 1;
          y.phase = "grinding";
        end
      elseif obj.s == "grinding"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.grinding = 0;
          y.phase = "down";
        end
      elseif obj.s == "down"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.on = 0;
          y.phase = "wait";
        end
      elseif obj.s == "wait"
        if abs(obj.sigma - e(1)) <= obj.epsilon
          y.leaving = 1;
          y.phase = "idle";
        end
      end
    end

    function t = ta(obj)
      t = [obj.sigma, 0];
    end

  end
end
