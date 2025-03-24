function out = testNserver1(showPlot)
  if ~exist("showPlot","var")
    showPlot = false;
  end

  tEnd = 10;
	model_generator("Nserver_Model1");
	out = model_simulator("Nserver_Model1", tEnd);

  if showPlot
    figure("name", "testNserver1", "NumberTitle", "off")
    subplot(3,1,1)
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Generator");

    subplot(3,1,2)
    stairs(out.srvnOut.t,out.srvnOut.y); grid on;
    hold("on");plot(out.srvnOut.t,out.srvnOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.1])
    xlabel("simulation time");
    ylabel("n");
    title("Server");

    subplot(3,1,3)
    stem(out.srvOut.t,[out.srvOut.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Server");
  end
end