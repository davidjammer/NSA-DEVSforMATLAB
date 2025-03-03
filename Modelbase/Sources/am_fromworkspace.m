classdef am_fromworkspace < handle
  %% Description
  %  sets output from global simin, whichcontains a variable varname with
  %      fields y(1:N) and t(1:N)
  %  output y(i) is sent at time t(i)
  %% Ports
  %  inputs: none
  %  outputs:
  %    out
  %% States
  %  s:     starting/ready
  %  index: index of next value
  %  sigma: time until next output
  %% System Parameters
  %  name:     object name
  %  varname:  name of the input variable (as field in gloabal simin)
  %  tau:      input delay
  %  debug:    flag to enable debug information
  properties
    s
    index
    sigma
    name
    varname
    tau
    debug
  end

  methods
    function obj = am_fromworkspace(name, varname, tau, debug)
      obj.s ="starting";
      obj.name = name;
      obj.varname = varname;
      obj.debug = debug;
      obj.tau = tau;
      obj.index = 1;
      obj.sigma = 0;
    end

    function delta(obj,e,x)
      global simin

      obj.s = "ready";

      if obj.index == length(simin.(obj.varname).t)
        obj.sigma = inf;
      else
        obj.index = obj.index + 1;
        obj.sigma = simin.(obj.varname).t(obj.index) - simin.(obj.varname).t(obj.index - 1);
      end
    end

    function y = lambda(obj,e,x)
      global simin

      y.out = simin.(obj.varname).y(obj.index);
    end

    function t = ta(obj)
      global simin

      if obj.s == "starting"
        t = [simin.(obj.varname).t(1), 0];
      else
        t = [obj.sigma, 0];
      end
    end

  end
end
