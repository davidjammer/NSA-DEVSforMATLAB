function [out] = testConst(showPlot)
	if nargin == 0
      showPlot = false;
    end

	tend = 10;
	model_generator("Const_Model");
	out = model_simulator("Const_Model", tend);
	
	if showPlot
		figure()
		stem(out.out.t,out.out.y); grid on;
		xlim([0 tend]);
		xlabel('simulation time');
		ylabel('out');
		title('const');
	end


end
