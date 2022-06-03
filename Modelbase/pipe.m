classdef pipe < handle
    properties
	   tau
	   s
	   name
	   E
	   epsilon = get_epsilon;
    end
    methods
	   function obj = pipe(name,tau)
		  obj.name = name;
		  obj.s = 'idle';
		  obj.tau = tau;
	   end
	   function delta(obj,e,x)
		  if(strcmp(obj.s,'idle'))
			 if (~isempty(x))
				obj.E = x.in;
				obj.s = 'wait';
			 end
		  else
			 if (~isempty(x))
				obj.E = x.in;
				obj.s = 'wait';
			 else
				obj.s = 'idle';
			 end
		  end
	   end
	   function y=lambda(obj,e,x)
		  y=[];
		  if(strcmp(obj.s,'idle'))
			 if (~isempty(x))
				y.out_p = x.in;
			 end
		  else
			 if (~isempty(x))
				y.out_p = x.in;
				y.out_d = obj.E;
			 else
				y.out_d = obj.E;
			 end
		  end
	   end
	   function t = ta(obj)
		  if(strcmp(obj.s,'idle'))
			 t = [Inf, 0];
		  else
			 t = [1.0, 0];
		  end
	   end
    end
end
