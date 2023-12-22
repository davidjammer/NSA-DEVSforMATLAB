classdef am_bin8_to_dec < handle
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
    function obj = am_bin8_to_dec(name, tau, debug)
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
        if x.in1 =="1"
            obj.in(1) = 1;
        elseif x.in1 == "0"
            obj.in(1) = 0;
        end
    end
    if isfield(x, "in2") 
        if x.in2 =="1"
            obj.in(2) = 1;
        elseif x.in2 == "0"
            obj.in(2) = 0;
        end
    end
    if isfield(x, "in3") 
        if x.in3 =="1"
            obj.in(3) = 1;
        elseif x.in3 == "0"
            obj.in(3) = 0;
        end
    end
    if isfield(x, "in4") 
        if x.in4 =="1"
            obj.in(4) = 1;
        elseif x.in4 == "0"
            obj.in(4) = 0;
        end
    end
    if isfield(x, "in5") 
        if x.in5 =="1"
            obj.in(5) = 1;
        elseif x.in5 == "0"
            obj.in(5) = 0;
        end
    end
    if isfield(x, "in6") 
        if x.in6 =="1"
            obj.in(6) = 1;
        elseif x.in6 == "0"
            obj.in(6) = 0;
        end
    end
    if isfield(x, "in7") 
        if x.in7 =="1"
            obj.in(7) = 1;
        elseif x.in7 == "0"
            obj.in(7) = 0;
        end
    end
    if isfield(x, "in8") 
        if x.in8 =="1"
            obj.in(8) = 1;
        elseif x.in8 == "0"
            obj.in(8) = 0;
        end
    end
        
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
     
    in = obj.in;
        
    if isfield(x, "in1") 
        if x.in1 =="1"
            in(1) = 1;
        elseif x.in1 == "0"
            in(1) = 0;
        end
    end
    if isfield(x, "in2") 
        if x.in2 =="1"
            in(2) = 1;
        elseif x.in2 == "0"
            in(2) = 0;
        end
    end
    if isfield(x, "in3") 
        if x.in3 =="1"
            in(3) = 1;
        elseif x.in3 == "0"
            in(3) = 0;
        end
    end
    if isfield(x, "in4") 
        if x.in4 =="1"
            in(4) = 1;
        elseif x.in4 == "0"
            in(4) = 0;
        end
    end
    if isfield(x, "in5") 
        if x.in5 =="1"
            in(5) = 1;
        elseif x.in5 == "0"
            in(5) = 0;
        end
    end
    if isfield(x, "in6") 
        if x.in6 =="1"
            in(6) = 1;
        elseif x.in6 == "0"
            in(6) = 0;
        end
    end
    if isfield(x, "in7") 
        if x.in7 =="1"
            in(7) = 1;
        elseif x.in7 == "0"
            in(7) = 0;
        end
    end
    if isfield(x, "in8") 
        if x.in8 =="1"
            in(8) = 1;
        elseif x.in8 == "0"
            in(8) = 0;
        end
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
