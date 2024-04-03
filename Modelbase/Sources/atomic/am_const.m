classdef am_const < handle
  %% Description
  %  Sends constant output at given (usually initial) time.
  %% Ports
  %  inputs: none
  %  outputs:
  %    out   given value
  %% States
  %  s:   running/ready
  %% System Parameters
  %  name:     object name
  %  value:    constant value
  %  sendTime: time, when value is sent (usually tau)
  %  tau:      input delay
  %  debug:    flag to enable debug information
  properties
    s
    name
    value
    sendTime
    debug
    tau
  end

  methods
    function obj = am_const(name, value, sendTime, tau, debug)
      obj.s ="running";
      obj.name = name;
      obj.value = value;
      obj.sendTime = sendTime;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      obj.s = "ready";
    end

    function y = lambda(obj,e,x)
      y.out = obj.value;

      if obj.debug
        fprintf("%-8s lambda, ", obj.name);
        if isfield(y, "out")
          fprintf("out=%2d ", y.out);
        end
        fprintf("\n")
      end
    end

    function t = ta(obj)
      if obj.s == "running"
        t = obj.sendTime;
      else
        t = [inf, 0];
      end
    end

  end
end
