classdef am_max2 < handle
  %% Description
  %  outputs maximal value of two inputs (simplified)
  properties
    in1
    in2
    name
    tau
    debug
  end

  methods
    function obj = am_max2(name, tau, debug)
      obj.in1 = -Inf;
      obj.in2 = -Inf;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if isfield(x, "in1")
        obj.in1 = x.in1;
      end
      if isfield(x, "in2")
        obj.in2 = x.in2;
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.in1;
      s2 = obj.in2;
      if isfield(x, "in1")
        s1 = x.in1;
      end
      if isfield(x, "in2")
        s2 = x.in2;
      end
      y.out = max(s1, s2);
    end

    function t = ta(obj)
      t = [inf, 0];
    end
  end
end
