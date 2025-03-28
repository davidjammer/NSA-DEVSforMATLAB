function out = testExpnserver1(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 20;
  rng(42);     % set seed for random generator

	load_system("Expnserver1_Model");
	model_generator("Expnserver1_Model");
	out = model_simulator("Expnserver1_Model", tEnd);

  if showPlot
    figure("name", "testExpnserver1", "NumberTitle", "off")
    subplot(2,2,1)
    stem(out.genOut.t,[out.genOut.y]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Generator");

    subplot(2,2,2)
    stairs(out.nqOut.t,out.nqOut.y); grid on;
    hold("on");plot(out.nqOut.t,out.nqOut.y, "*");hold("off");
    xlim([0 tEnd]);
    %ylim([-0.1, 3.1])
    xlabel("simulation time");
    ylabel("nq");
    title("Queue");

    subplot(2,2,3)
    stairs(out.nsOut.t,out.nsOut.y); grid on;
    hold("on");plot(out.nsOut.t,out.nsOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.5])
    xlabel("simulation time");
    ylabel("ns");
    title("Server");
  
    subplot(2,2,4)
    stem(out.srvOut.t,out.srvOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Server");
  end
end