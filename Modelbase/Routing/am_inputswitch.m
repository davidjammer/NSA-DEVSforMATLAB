classdef am_inputswitch < handle
  %% Description
  %  routes one of two inputs to the output according to sw input
  %% Ports
  %  inputs:
  %    in1/2     incoming entities
  %    sw        input selector
  %  outputs:
  %    out       outgoing entities
  %% States
  %  s:        running
  %  nextPort: current input port routed to output
  %% System Parameters
  %  name:  object name
  %  port0: initial input port
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    nextPort
    name
    port0
    debug
    tau
  end

  methods
    function obj = am_inputswitch(name, port0, tau, debug)
      obj.s = "running";
      obj.nextPort = port0;
      obj.name = name;
      obj.port0 = port0;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end

      if isfield(x, "sw")
        obj.nextPort = double(x.sw) + 1;
      end

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
      end
    end

    function y = lambda(obj,e,x)
      curPort = obj.nextPort;
      if isfield(x, "sw")
        curPort = double(x.sw) + 1;
      end

      if isfield(x, "in1") && curPort == 1
        y.out = x.in1;
      elseif isfield(x, "in2") && curPort == 2
        y.out = x.in2;
      else
        y = [];
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

    %-------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s nextPort=%d\n", obj.s, obj.nextPort)
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in1")
        fprintf("in1=[ %s] ", getDescription(x.in1));
      end
      if isfield(x, "in2")
        fprintf("in2=[ %s] ", getDescription(x.in2));
      end
      if isfield(x, "sw")
        fprintf("sw=%d ", x.sw);
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "out")
        fprintf("out=[ %s] ", getDescription(y.out));
      end
      fprintf("\n")
    end

  end
end
