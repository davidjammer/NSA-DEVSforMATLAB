classdef hIntegrator < handle
    
    
    properties
	   dX
	   dq
	   X
	   q
	   epsilon
	   sigma
	   name
	   debug
	   tau
    end
    
    methods
	   function obj = hIntegrator(name, tau, debug, dq, epsilon, X)
		  obj.dq = dq;
		  obj.sigma = 0;
		  obj.dX = 0;
		  obj.X = X;
		  obj.epsilon = epsilon;
		  obj.q = floor(obj.X/obj.dq) * obj.dq;
		  obj.name = name;
		  obj.debug = debug;
		  obj.tau = tau;
	   end
	   
	   function delta(obj,e,x)
		  if isempty(x)
			 obj.X = obj.X + obj.sigma * obj.dX;
			 if obj.dX > 0.0
				obj.sigma = obj.dq/obj.dX;
				obj.q = obj.q + obj.dq;
			 elseif obj.dX < 0.0
				obj.sigma = -obj.dq/obj.dX;
				obj.q = obj.q - obj.dq;
			 else
				obj.sigma = Inf;
			 end
			 
		  else
			 obj.X = obj.X + obj.dX * e;
			 if x.in > 0.0
				obj.sigma = (obj.q + obj.dq - obj.X)/x.in;
			 elseif x.in < 0.0
				obj.sigma = (obj.q - obj.epsilon - obj.X)/x.in;
			 else
				obj.sigma = Inf;
			 end
			 obj.dX = x.in;
		  end
		  
	   end
	   
	   function y = lambda(obj,e,x)
		  if isempty(x) 
			 if obj.dX == 0.0
				y.out = obj.q;
			 else
				y.out = obj.q + obj.dq * (obj.dX / abs(obj.dX));
			 end
		  else
			 y = [];
		  end
	   end
	   
	   function t = ta(obj)
		  t = [obj.sigma, 0];
	   end  
    end
end