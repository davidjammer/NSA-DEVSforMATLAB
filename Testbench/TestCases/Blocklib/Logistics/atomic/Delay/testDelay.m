function out = testDelay()

	tEnd = 21;
	model_generator("Delay_Model");
	out = model_simulator("Delay_Model", tEnd);
	
	
	if 0
		figure("Position",[1 1 450 500]);
		subplot(2,1,1)
		stairs(out.genOut.t,out.genOut.y);
		hold("on"); plot(out.genOut.t,out.genOut.y, "*"); hold("off");
		grid("on");
		xlim([0, tEnd])
		ylim([-3.2, 2.2])
		xlabel("simulation time");
		ylabel("out");
		title("Delay in");
	
		subplot(2,1,2)
		stairs(out.DelayOut.t,out.DelayOut.y);
		hold("on"); plot(out.DelayOut.t,out.DelayOut.y, "*"); hold("off");
		grid("on");
		xlim([0, tEnd])
		ylim([-3.2, 2.2])
		xlabel("simulation time");
		ylabel("out");
		title("Delay out");
	end

end
