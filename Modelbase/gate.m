classdef gate < handle
  %% Description
  %  Sends input entities to outpit, if gate is open,
  %  otherwise entities "disappear" !
  %% Ports
  %  inputs:
  %    in     incoming entities
  %    open   state of gate
  %  outputs:
  %    out    outgoing entities
  %    n      ?? 
  %% States
  %  s: running
  %
  %% System Parameters
  %  name:  object name
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    open
    name
    debug
    tau
  end

  methods
    function obj = gate(name, tau, debug)
      obj.s = "running";
      obj.open = 0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if ~isempty(x) && isfield(x, "open")
        open = x.open;
      end
    end

    function y = lambda(obj,e,x)
      open = obj.open;
      if ~isempty(x) && isfield(x, "open")
        open = x.open;
      end

      if open == 1 && ~isempty(x) && isfield(x, "in")
        y.out = x.in;
        y.n = 1;
      else
        y = [];
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
