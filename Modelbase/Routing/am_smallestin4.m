classdef am_smallestin4 < handle
%% Description
%  outputs index of smallest input value among 4 inputs
%% Ports
%  inputs: 
%    in1, in2, in3 , in4  incoming values
%  outputs: 
%    out      index of smallest input
%% States
%  s: running
%  n: vector of arrived values
%% System Parameters
%  name:  object name
%  val0:  initial output index
%  tau:   input delay
%  debug: flag to enable debug information
 
  properties
    s
    n
    name
    val0
    debug
    tau
  end
  
  methods
      function obj = am_smallestin4(name, val0, tau, debug)
      obj.s = "running";
      obj.n = zeros(1,4) + val0;
      obj.name = name;
      obj.val0 = val0;
      obj.debug = debug;
      obj.tau = tau;
    end
    
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end
      
      if isfield(x, "in1")
        obj.n(1) = x.in1;
      end
      if isfield(x, "in2")
        obj.n(2) = x.in2;
      end
      if isfield(x, "in3")
        obj.n(3) = x.in3;
      end
      if isfield(x, "in4")
        obj.n(4) = x.in4;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
    
    function y = lambda(obj,e,x)
      vals = obj.n;
      if isfield(x, "in1")
        vals(1) = x.in1;
      end
      if isfield(x, "in2")
        vals(2) = x.in2;
      end
      if isfield(x, "in3")
        vals(3) = x.in3;
      end
      if isfield(x, "in4")
        vals(4) = x.in4;
      end
      [~, y.out] = min(vals);
      
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
      fprintf("  n=%s\n", getDescription(obj.n));
   end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  input:  %s\n", getDescription(x))
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf("  output: %s\n", getDescription(y))
    end

  end
end
