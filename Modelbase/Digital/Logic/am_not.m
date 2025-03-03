classdef am_not < handle
%% Description
%  logical NOT block
%  works with logical or IEEE1164 values
%% Ports
%  inputs: 
%    in
%  outputs: 
%    out
%% States
%  s:    running
%  in1:  last input value
%% System Parameters
%  name:  object name
%  tau:   input delay
%  debug: flag to enable debug information

  properties
    s
    in1
    name
    debug
    tau
  end
  
  methods
    function obj = am_not(name, tau, debug)
      obj.s = "running";
      obj.name = name;
      obj.in1 = "U";
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e, x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end
      if isfield(x, "in")
        obj.in1 = x.in;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj);
      end
    end
   
    function y = lambda(obj, e, x)
      s = obj.in1;
      if isfield(x, "in")
        s = x.in;
      end
      if islogical(s)
        y.out = ~s;
      else
        y.out = ieee1164_not(s);
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end
    
    function t = ta(obj)
      t = inf;
    end
        
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%4s in1=%s \n", obj.s, obj.in1)
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in")
        fprintf("%s", x.in);
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "out")
        fprintf("%s", y.out);
      end
      fprintf("\n")
    end
  end
end
