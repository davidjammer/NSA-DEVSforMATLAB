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
        fprintf("%-8s delta in\n", obj.name)
        showState(obj)
      end
      
      if isfield(x, "port")
        obj.nextPort = x.port;
      end

      if obj.debug
        fprintf("%-8s delta out\n", obj.name)
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
       showInput(obj, x)
       if isfield(x, "in")
          fprintf("%-8s lambda, out=%2d at port %d\n", obj.name, x.in, port)
        end
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
      fprintf("%-8s lambda, x: ", obj.name)
      if isfield(x, "in")
        fprintf(" in=%f", x.in);
      end
      if isfield(x, "port")
        fprintf(" port=%2d", x.port);
      end
      fprintf("\n")
    end  

  end
end
