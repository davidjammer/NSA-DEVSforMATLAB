classdef am_saturation < handle
  %% Description
  %  Limits the input value between an upper and lower limit
  %% Ports
  %  inputs:
  %    in       incoming value
  %  outputs:
  %    out      outgoing value
  %% States
  %  s:   running
  %% System Parameters
  %  name:  object name
  %  ll:    lower limit
  %  ul:    uper limit
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    ll
    ul
    name
    debug
    tau
  end

  methods
    function obj = am_saturation(name, ll, ul, tau, debug)
      obj.s ="running";
      obj.name = name;
      obj.ll = ll;
      obj.ul = ul;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)

    end

    function y = lambda(obj,e,x)
      y = [];
      if ~isempty(x)
        if x.in < obj.ll
          y.out = obj.ll;
        elseif x.in > obj.ul
          y.out = obj.ul;
        else
          y.out = x.in;
        end
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
