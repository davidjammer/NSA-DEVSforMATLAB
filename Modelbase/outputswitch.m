classdef outputswitch < handle
%% Description
%  routes input to one of two outputs according to sw input
%% Ports
%  inputs: 
%    in        incoming value
%    sw        output selector
%  outputs: 
%    out1/2    outgoing entities
%% States
%  s:        running
%  nextPort: output port of new in values
%% System Parameters
%  name:  object name
%  port0: initial port
%  debug: flag to enable debug information
%  tau:     infinitesimal delay

  properties
    s
    nextPort
    name
    port0
    debug
    tau
  end
  
  methods
    function obj = outputswitch(name, port0, tau, debug)
      obj.s = "running";
      obj.nextPort = port0;
      obj.name = name;
      obj.port0 = port0;
      obj.debug = debug;
      obj.tau = tau;
    end
           
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in, port=%2d\n", obj.name, obj.nextPort)
      end
      
      if isfield(x, "sw")
        obj.nextPort = x.sw + 1;
      end
        
      if obj.debug
        fprintf("%-8s delta out, port=%2d\n", obj.name, obj.nextPort)
      end
    end
       
    function y = lambda(obj,e,x)
      if isfield(x, "in")
        curPort = obj.nextPort;
        if isfield(x, "sw")
          curPort = x.sw + 1;
        end
        
        switch curPort
          case 1
            y.out1 = x.in;
            y.out2 = [];
          case 2
            y.out1 = [];
            y.out2 = x.in;
          otherwise
            fprintf("la: wrong port %d in %s\n", curPort, obj.name);
        end
      else
        y = [];
      end
      
      if obj.debug
        sIn = showInput(obj, x);
        switch curPort
          case 1
            fprintf("%-8s lambda, %s, out1=%2d out2=[]\n", ...
              obj.name, sIn, y.out1);
          case 2
            fprintf("%-8s lambda, %s, out1=[] out2=%2d\n", ...
              obj.name, sIn, y.out2);
        end 
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
    
    %-------------------------------------------------------
    function sIn = showInput(obj, x)
      sIn = "";
      if isfield(x, "sw")
        sIn = sIn + sprintf("sw=%d ", x.sw);        
      end
      if isfield(x, "in")
        sIn = sIn + sprintf("in=%d ", x.in);        
      end
    end
    
  end
end
