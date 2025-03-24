function [out] = testServer(testcase,showPlot)

    if ~exist('testcase','var')
      testcase = 1;
    end
	if ~exist('showPlot','var')
      showPlot = 0;
    end
    
    switch testcase
      case 1   % generator too fast -> loosing entities
        tG = 1.0;
      case 2   % correct behaviour
        tG = 2.0;
      otherwise
        tG = 2.0;
    end

    tEnd = 8;
    
	load_system("Server_Model");
	set_param("Server_Model/am_generator", "tG", string(tG));

	model_generator("Server_Model");
	out = model_simulator("Server_Model", tEnd);

    if showPlot
        % plot results
        figure("name", "testServer", "NumberTitle", "off")
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
        ylim([-0.1, 1.1])
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