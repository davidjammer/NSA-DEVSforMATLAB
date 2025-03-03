classdef am_hIntegrator < handle
  %% Description
  %  QSS H-Integrator of first order
  %% Ports
  %  inputs:
  %    in   incoming value
  %  outputs:
  %    out  integral of incoming value, computed with QSS1 method
  %% States
  %  s:     running
  %  dX:    last input value
  %  X:     current value of state variable
  %  q:     quantized value of X
  %  sigma: time until next event
  %% System Parameters
  %  name:    object name
  %  dq:      quantum of q
  %  epsilon: hysteresis width (generally = dq)
  %  X0:      initial value of X
  %  tau:     input delay
  %  debug:   model debug level

  properties
    s
    dX
    X
    q
    sigma
    name
    dq
    epsilon
    X0
    tau
    debug
  end

  methods
    function obj = am_hIntegrator(name, dq, epsilon, X0, tau, debug)
      obj.name = name;
      obj.dq = dq;
      obj.epsilon = epsilon;
      obj.X0 = X0;
      obj.tau = tau;
      obj.debug = debug;
      obj.s ="running";
      obj.dX = 0;
      obj.X = X0;
      obj.q = floor(obj.X/obj.dq) * obj.dq;
      obj.sigma = 0;
    end

    function delta(obj,e,x)
      if isempty(x)
        obj.X = obj.X + obj.sigma * obj.dX;
        if obj.dX > 0.0
          obj.sigma = obj.dq/obj.dX;
          obj.q = obj.q + obj.dq;
        elseif obj.dX < 0.0
          obj.sigma = -obj.dq/obj.dX;
          obj.q = obj.q - obj.dq;
        else
          obj.sigma = Inf;
        end
      else
        obj.X = obj.X + obj.dX * e; 
        if x.in > 0.0
          obj.sigma = (obj.q + obj.dq - obj.X)/x.in;
        elseif x.in < 0.0
          obj.sigma = (obj.q - obj.epsilon - obj.X)/x.in;
        else
          obj.sigma = Inf;
        end
        obj.dX = x.in;
      end

    end

    function y = lambda(obj,e,x)
      if isempty(x)
        if obj.dX == 0.0
          y.out = obj.q;
        else
          y.out = obj.q + obj.dq * (obj.dX / abs(obj.dX));
        end
      else
        y = [];
      end
    end

    function t = ta(obj)
      t = [obj.sigma, 0];
    end
  end
end
