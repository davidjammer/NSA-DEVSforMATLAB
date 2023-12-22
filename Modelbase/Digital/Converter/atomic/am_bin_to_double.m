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
				if x.in == "1"
					y.out = 1;
				elseif x.in == "0"
					y.out = 0;
				end
			end
		end
		function t = ta(obj)
			t = [Inf, 0];
		end
	end
end
