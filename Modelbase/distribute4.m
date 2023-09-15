classdef distribute4 < handle
%% Description
%  routes entities to one of four outputs according to port input
%% Ports
%  inputs: 
%    in        incoming entities
%    port      next output port
%  outputs: 
%    out1/2/3/4  outgoing entities
%% States
%  s:        running
%  nextPort: output port of new in values
%% System Parameters
%  name:  object name
%  port0: initial output port
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
    function obj = distribute4(name, port0, tau, debug)
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
        port = obj.nextPort;
        if isfield(x, "port")
          port = x.port;
        end
        switch port
          case 1
            y.out1 = x.in;
          case 2
            y.out2 = x.in;
          case 3
            y.out3 = x.in;
          case 4
            y.out4 = x.in;
          otherwise
           fprintf("lambda: wrong port %d in %s\n", port, obj.name);
        end
      else
        y = [];
      end
      
      if obj.debug
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

  end
end
