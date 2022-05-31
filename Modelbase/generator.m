
classdef generator < handle
    
    properties
		s
        name
        ts
        id
        epsilon = get_epsilon;
        tau
    end
    methods
        function obj = generator(name,ts,tau)
            obj.name = name;
            obj.s = 'prod';
            obj.ts = ts;
            obj.id = 0;
            obj.tau = tau;
        end
        function delta(obj,e,x)
           
        	if abs(e(1) - obj.ts) <= obj.epsilon
            	obj.s = 'prod';
				obj.id = obj.id + 1;
			end
		end
        function y=lambda(obj,e,x) 
            
        	if abs(e(1) - obj.ts) <= obj.epsilon
				y.out = obj.id;
			else
				y=[];
			end	
        end
        function t = ta(obj)
			t = [obj.ts, 0];
        end
    end
   
end
