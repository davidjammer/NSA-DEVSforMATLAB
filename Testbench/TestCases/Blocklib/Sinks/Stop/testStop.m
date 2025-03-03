function out = testStop(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 12;

	load_system("Stop_Model");
	model_generator("Stop_Model");
	out = model_simulator("Stop_Model", tEnd);

  if showPlot
    figure("name", "testStop", "NumberTitle", "off", "Position",[1 1 400 250])
    stem(out.dataOut.t, out.dataOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 10]);
    xlabel("simulation time");
    ylabel("id");
    title("Data");
  end
end