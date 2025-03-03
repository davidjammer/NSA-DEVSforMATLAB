classdef am_distribute2 < handle
  %% Description
  %  routes entities to one of two outputs according to data field or port input
  %% Ports
  %  inputs:
  %    in        incoming entities
  %    port      next output port
  %  outputs:
  %    out1/2    outgoing entities
  %% States
  %  s:        running
  %  nextPort: output port of new in values
  %% System Parameters
  %  name:  object name
  %  port0: initial output port
  %  field: name of field containing the outport port number ("": use port input)
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    nextPort
    name
    port0
    field
    debug
    tau
  end

  methods
    function obj = am_distribute2(name, port0, field, tau, debug)
      obj.s = "running";
      obj.nextPort = port0;
      obj.name = name;
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

        switch port
          case 1
            y.out1 = x.in;
            y.out2 = [];
          case 2
            y.out1 = [];
            y.out2 = x.in;
          otherwise
            fprintf("lambda: wrong port %d in %s\n", port, obj.name);
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
      fprintf("  phase=%s nextPort=%2d\n", obj.s, obj.nextPort);
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in")
        fprintf("[ %s] ", getDescription(x.in));
      end
      if isfield(x, "port")
        fprintf("port=%1d", x.port);
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if ~isempty(y.out1)
        fprintf("[ %s] at port 1", getDescription(y.out1));
      elseif ~isempty(y.out2)
        fprintf("[ %s] at port 2", getDescription(y.out2));
      end
      fprintf("\n")
    end
  end
end
