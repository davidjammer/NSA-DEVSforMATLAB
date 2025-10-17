function out = testDelay1(showPlot)
  % delay of entities
	if nargin == 0
      showPlot = false;
    end

	tEnd = 15;
	model_generator("Delay1_Model");
	out = model_simulator("Delay1_Model", tEnd);
	
	
	if showPlot
		figure("Position",[1 1 450 500]);
		subplot(2,1,1)
		stem(out.genOut.t,[out.genOut.y.id]);
		grid("on");
		xlim([0, tEnd])
		xlabel("simulation time");
		ylabel("out");
		title("Delay in");
	
		subplot(2,1,2)
		stem(out.DelayOut.t,[out.DelayOut.y.id]);
		grid("on");
		xlim([0, tEnd])
		xlabel("simulation time");
		ylabel("out");
		title("Delay out");
	end

end
