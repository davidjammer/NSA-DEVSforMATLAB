function out = testAdddata(showPlot)
  if nargin == 0
    showPlot = false;
  end
   
  tEnd = 13;
    
	load_system("Adddata_Model");
	model_generator("Adddata_Model");
	out = model_simulator("Adddata_Model", tEnd);

  if showPlot
    figure("name", "testAdddata", "NumberTitle", "off")
    subplot(3,2,1)
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Generator");

    subplot(3,2,2)
    stairs(out.nqOut.t,out.nqOut.y); grid on;
    hold("on");plot(out.nqOut.t,out.nqOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.1])
    xlabel("simulation time");
    ylabel("nq");
    title("Queue");

    subplot(3,2,3)
    stem(out.srv2Out.t,[out.srv2Out.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Server");

    subplot(3,2,4)
    stairs(out.nsOut.t,out.nsOut.y); grid on;
    hold("on");plot(out.nsOut.t,out.nsOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.5])
    xlabel("simulation time");
    ylabel("ns");
    title("Server");
  
    subplot(3,2,5)
    stem(out.srv2Out.t,[out.srv2Out.y.age]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("age");
    title("Server");

  end
end