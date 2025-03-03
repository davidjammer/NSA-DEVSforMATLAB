function out = testExpserver(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 15;

	load_system("Expserver_Model");
	model_generator("Expserver_Model");
	out = model_simulator("Expserver_Model", tEnd);

  if showPlot
    figure("name", "testExpserver", "NumberTitle", "off")
    subplot(2,2,1)
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("time");
    ylabel("id");
    title("Generator");

    subplot(2,2,2)
    stairs(out.nqOut.t,out.nqOut.y); grid on;
    hold("on");plot(out.nqOut.t,out.nqOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.1])
    xlabel("time");
    ylabel("nq");
    title("Queue");

    subplot(2,2,3)
    stem(out.srvOut.t,[out.srvOut.y]); grid on;
    xlim([0 tEnd]);
    xlabel("time");
    ylabel("id");
    title("Server");

    subplot(2,2,4)
    stairs(out.nsOut.t,out.nsOut.y); grid on;
    hold("on");plot(out.nsOut.t,out.nsOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 1.1])
    xlabel("time");
    ylabel("ns");
    title("Server");
  end
end