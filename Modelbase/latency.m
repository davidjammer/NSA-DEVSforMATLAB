classdef latency < handle


  properties
    out
    dt
    name
    debug
    tau
  end
    
  methods
    function obj = latency(name, tau, debug, dt)
      obj.out = [];
	 obj.dt = dt;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
        
    function delta(obj,e,x)
      
	   if isempty(x)
		  obj.out = obj.out(2:end);
	   else
		  for i=1:length(obj.out)
			obj.out(i).e = obj.out(i).e - e; 
		  end
		  if isfield(x,"in")
			value.x = x.in;
			value.e = obj.dt;
			obj.out = [obj.out, value];
		  end
	   end
    end
    
    function y = lambda(obj,e,x)
	   if isempty(x)
		y.out = obj.out(1).x;
	   else
		  y = [];
	   end    
    end
       
    function t = ta(obj)
	   if isempty(obj.out)
		t = [Inf, 0];  
	   else
		t = [obj.out(1).e, 0];
	   end
    end
  end
end
