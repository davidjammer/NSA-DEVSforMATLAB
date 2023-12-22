function [out] = testGetmax()
	global simin

	tend = 10;
	simin.in.t = [0,  1, 2,  3, 4, 5];
	simin.in.y = [2,  1, 10, 7, 3, 11];
	
	model_generator("Getmax_Model");
	out = model_simulator("Getmax_Model", tend);
	
	if 0
		figure()
		subplot(2,1,1)
		stem(out.genout.t,out.genout.y); grid on;
		xlim([0 tend]);
		xlabel('simulation time');
		ylabel('out');
		title('input');
	
		subplot(2,1,2)
		stem(out.maxout.t,out.maxout.y); grid on;
		xlim([0 tend]);
		xlabel('simulation time');
		ylabel('out');
		title('max');
	end


end
