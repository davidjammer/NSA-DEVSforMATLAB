classdef triggeredserver < handle
  %% Description
  %  Stores an incoming entity, until a leaving signal arrives.
  %% Ports
  %  inputs:
  %    in        incoming entity
  %    leaving   ready signal
  %  outputs:
  %    out       outgoing entity
  %    entered   1, when an entity enters
  %    working   0/1 = number of stored entities
  %% States
  %  s: {idle, working}
  %  E: stored entity
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:   infinitesimal delay

  properties
    s
    E
    name
    debug
    tau
  end

  methods
    function obj = triggeredserver(name, tau, debug)
      obj.s = "idle";
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)

      if obj.s == "idle"
        if ~isempty(x) && isfield(x, "in")
          obj.E = x.in;
          obj.s = "working";
        end
      else
        if ~isempty(x) && isfield(x, "leaving") && x.leaving
          obj.s = "idle";
          obj.E = [];
        end
      end

    end

    function y = lambda(obj,e,x)
      y = [];
      if obj.s == "idle"
        if ~isempty(x) && isfield(x, "in")
          y.entered = true;
          y.working = true;
        end
      else
        if ~isempty(x) && isfield(x, "leaving") && x.leaving 
          y.out = obj.E;
          y.working = false;
        end
      end

    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
