classdef comparator2 < handle
%% Description
%  returns 1 if in1 >= in2, else 0
%% Ports
%  inputs: 
%    in1, in2    incoming value
%  outputs: 
%    out1      1 if in1 >= in2, else 0
%    out2      1 if in1 <= in2, else 0
%    out3      1 if in1 >  in2, else 0
%    out4      1 if in1 <  in2, else 0
%% States
%  s:   running
%% System Parameters
%  name:  object name
%  debug: flag to enable debug information
%  tau:   infinitesimal delay

  properties
    s
    in1
    in2
    name
    debug
    tau
  end
  
  methods
    function obj = comparator2(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.tau = tau;
	 obj.in1 = 0;
	 obj.in2 = 0;
      obj.debug = debug;
    end
          
    function delta(obj,e,x)
      if ~isempty(x)
		if isfield(x, "in1")
		    obj.in1 = x.in1;
		end
		if isfield(x, "in2")
		    obj.in2 = x.in2;
		end
	 end
    end
                  
    function y = lambda(obj,e,x)
      in1 = obj.in1;
	 in2 = obj.in2;
	 if ~isempty(x)
		if isfield(x, "in1")
		    in1 = x.in1;
		end
		if isfield(x, "in2")
		    in2 = x.in2;
		end
	 end
	 
	 if in1 >= in2
		y.out1 = 1;
	 else
		y.out1 = 0;
	 end
	 if in1 <= in2
		y.out2 = 1;
	 else
		y.out2 = 0;
	 end
	 if in1 > in2
		y.out3 = 1;
	 else
		y.out3 = 0;
	 end
	 if in1 < in2
		y.out4 = 1;
	 else
		y.out4 = 0;
	 end
    end
    
    function t = ta(obj)
      t = [inf,0];
    end
   
  end
end
