function [out] = testFromworkspace()

	global simin
	
	
	
	tend = 10;
	simin.in.t = [0,  1, 2, 3, 4, 5];
	simin.in.y = [10,11,12,13,14,15];
	
	model_generator("Fromworkspace_Model");
	out = model_simulator("Fromworkspace_Model", tend);
	
	if 0
		figure()
		stem(out.out.t,out.out.y); grid on;
		xlim([0 tend]);
		xlabel('simulation time');
		ylabel('out');
		title('fromworkspace');
	end


end
