function out = testNserver(testcase, showPlot)
  if nargin == 0
    testcase = 1;
    showPlot = false;
  elseif nargin == 1
    showPlot = false;
  end
    
  switch testcase
    case 1   % standard behaviour
      tS = 2.8;
      nG = 6;
      tEnd = 10;
    case 2   % confluent events
      tS = 3.0;
      nG = 6;
      tEnd = 10;
    case 3   % generator too fast -> loosing entities
      tS = 3.5;
      nG = 8;
      tEnd = 12;
    otherwise
      tS = 2.8;
      nG = 6;
      tEnd = 10;
  end

    
	load_system("Nserver_Model");
	set_param("Nserver_Model/am_nserver", "tS", string(tS));
	set_param("Nserver_Model/am_generator", "nG", string(nG));

	model_generator("Nserver_Model");
	out = model_simulator("Nserver_Model", tEnd);

  if showPlot
    figure("name", "testNserver", "NumberTitle", "off")
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
    stem(out.srvOut.t,out.srvOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Server");
  end
end