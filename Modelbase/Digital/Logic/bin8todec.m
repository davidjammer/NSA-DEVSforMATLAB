classdef bin8todec < handle
%% Description
%  convert binary to decimal
%% Ports
%  inputs: 
%    in1:8 input values
%  outputs: 
%    out      output value
%% States
%  s: {}
%  in[1:8] input values
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  r:     infinitesimal delay

  properties
    s
    name
    debug
    tau
    in
    c
  end
    
  methods
    function obj = bin8todec(name, tau, debug)
      obj.s = "init";
      obj.in = zeros(1,8);
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
      obj.c =[1,2,4,8,16,32,64,128];
    end
        
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end
      
      obj.s = "running";
      
      if isfield(x, "in1")
        obj.in(1) = x.in1;
      end
      if isfield(x, "in2")
        obj.in(2) = x.in2;
      end
      if isfield(x, "in3")
        obj.in(3) = x.in3;
      end
      if isfield(x, "in4")
        obj.in(4) = x.in4;
      end
      if isfield(x, "in5")
        obj.in(5) = x.in5;
      end
      if isfield(x, "in6")
        obj.in(6) = x.in6;
      end
      if isfield(x, "in7")
        obj.in(7) = x.in7;
      end
      if isfield(x, "in8")
        obj.in(8) = x.in8;
      end
        
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
     
     in = obj.in;
        
     if isfield(x, "in1")
        in(1) = x.in1;
      end
      if isfield(x, "in2")
        in(2) = x.in2;
      end
      if isfield(x, "in3")
        in(3) = x.in3;
      end
      if isfield(x, "in4")
        in(4) = x.in4;
      end
      if isfield(x, "in5")
        in(5) = x.in5;
      end
      if isfield(x, "in6")
        in(6) = x.in6;
      end
      if isfield(x, "in7")
        in(7) = x.in7;
      end
      if isfield(x, "in8")
        in(8) = x.in8;
      end
      
      
      
      if in == obj.in
          if obj.s == "init"
               y.out = sum(obj.c .* in); 
          else
               y=[];
          end
      else
          y.out = sum(obj.c .* in);
      end
      
      if obj.debug
        fprintf("%-8s lambda, out=%2d\n", obj.name, y.out)
      end
    end    
       
    function t = ta(obj)
        if obj.s == "init"
            t = obj.tau;
        else
            t = [inf, 0];
        end
    end
    
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s i1=%3d i2=%3d\n", obj.s, obj.i1, obj.i2);
    end  

  end
end
