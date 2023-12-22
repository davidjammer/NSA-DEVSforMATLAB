classdef am_dec_to_bin8 < handle
%% Description
%  convert decimal to binary
%% Ports
%  inputs: 
%    in1  input value
%  outputs: 
%    out1:8      output values
%% States
%  s: {}
%  in input value
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
    function obj = am_dec_to_bin8(name, tau, debug)
      obj.s = "init";
      obj.in = 0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end
      
      obj.s = "running";
      
      if isfield(x, "in1")
        obj.in = x.in1;
      end
        
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
     
      in = obj.in;
      out = zeros(1,8);
        
      if isfield(x, "in1")
        in = x.in1;
      end   
      
      if in == obj.in
          if obj.s == "init"
               tmp=flip(dec2bin(in)-'0');
               out(1:numel(tmp)) = tmp(1:end);
               
               y.out1 = convertCharsToStrings(num2str(out(1)));
               y.out2 = convertCharsToStrings(num2str(out(2)));
               y.out3 = convertCharsToStrings(num2str(out(3)));
               y.out4 = convertCharsToStrings(num2str(out(4)));
               y.out5 = convertCharsToStrings(num2str(out(5)));
               y.out6 = convertCharsToStrings(num2str(out(6)));
               y.out7 = convertCharsToStrings(num2str(out(7)));
               y.out8 = convertCharsToStrings(num2str(out(8)));
          else
               y=[];
          end
      else
          tmp=flip(dec2bin(in)-'0');
          out(1:numel(tmp)) = tmp(1:end);

          y.out1 = convertCharsToStrings(num2str(out(1)));
          y.out2 = convertCharsToStrings(num2str(out(2)));
          y.out3 = convertCharsToStrings(num2str(out(3)));
          y.out4 = convertCharsToStrings(num2str(out(4)));
          y.out5 = convertCharsToStrings(num2str(out(5)));
          y.out6 = convertCharsToStrings(num2str(out(6)));
          y.out7 = convertCharsToStrings(num2str(out(7)));
          y.out8 = convertCharsToStrings(num2str(out(8)));
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
