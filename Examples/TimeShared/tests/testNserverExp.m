function out = testNserverExp(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 20;
  rng(42);     % set seed for random generator

	load_system("NserverExp_Model");
	model_generator("NserverExp_Model");
	out = model_simulator("NserverExp_Model", tEnd);

  if showPlot
    figure("name", "testNserverExp", "NumberTitle", "off")
    subplot(3,2,1)
    stem(out.genOut.t,[out.genOut.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Generator");

    subplot(3,2,2)
    stairs(out.nqOut.t,out.nqOut.y); grid on;
    hold("on");plot(out.nqOut.t,out.nqOut.y, "*");hold("off");
    xlim([0 tEnd]);
    %ylim([-0.1, 3.1])
    xlabel("simulation time");
    ylabel("nq");
    title("Queue");

    subplot(3,2,3)
    stem(out.genOut.t,[out.genOut.y.serviceTime]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("t_S");
    title("Generator");

    subplot(3,2,4)
    stairs(out.nsOut.t,out.nsOut.y); grid on;
    hold("on");plot(out.nsOut.t,out.nsOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.5])
    xlabel("simulation time");
    ylabel("ns");
    title("Server");
  
    subplot(3,2,5)
    stem(out.srvOut.t,[out.srvOut.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Server");
  end
end