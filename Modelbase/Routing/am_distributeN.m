classdef am_distributeN < handle
  %% Description
  %  routes entities to one of N outputs according to data field or port input
  %% Ports
  %  inputs:
  %    in            incoming entities
  %    port          next output port
  %  outputs:
  %    out1 .. outN  outgoing entities
  %% States
  %  s:        running
  %  nextPort: output port of new in values
  %% System Parameters
  %  name:  object name
  %  N:     number of outputs
  %  port0: initial output port
  %  field: name of field containing the outport port number ("": use port input)
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    nextPort
    name
    N
    port0
    field
    debug
    tau
  end

  methods
    function obj = am_distributeN(name, N, port0, field, tau, debug)
      obj.s = "running";
      obj.nextPort = port0;
      obj.name = name;
      obj.N = N;
      obj.port0 = port0;
      obj.field = field;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      if isfield(x, "port")
        obj.nextPort = x.port;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      if isfield(x, "in")
        if obj.field == ""
          port = obj.nextPort;
          if isfield(x, "port")
            port = x.port;
          end
        else
          port = x.in.(obj.field);
        end

        for I=1:obj.N
          outName = "out"+I;
          if I == port
            y.(outName) = x.in;
          else
            y.(outName) = [];
          end
        end
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

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s nextPort=%d\n", obj.s, obj.nextPort);
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in")
        fprintf("in=%s ", getDescription(x.in));
      end
      if isfield(x, "port")
        fprintf("port=%d", x.port);
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if ~isempty(y)
        for I=1:obj.N
          outName = "out" + I;
          val = y.(outName);
          if ~isempty(val)
            fprintf("%s=%s", outName, getDescription(val))
          end
        end
      end
      fprintf("\n")
    end

  end
end
