classdef am_bin_to_double < handle
	properties
		tau
		s
		name
		debug
	end
	methods
		function obj = am_bin_to_double(name,tau,debug)
			obj.name = name;
			obj.s = 'idle';
			obj.tau = tau;
			obj.debug = debug;
		end
		function delta(obj,e,x)
			
		end
		function y=lambda(obj,e,x)
			y = [];
			if ~isempty(x)
        y.out = double(x.in);
			end
		end
		function t = ta(obj)
			t = [Inf, 0];
		end
	end
end
