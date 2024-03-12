function [out] = testUtilization(showPlot)
    if nargin == 0
      showPlot = false;
    end

    tEnd = 1000;
	model_generator("Utilization_Model");
	out = model_simulator("Utilization_Model", tEnd);
    
    if showPlot
        % plot results
        figure('Position',[1 1 550 350])
        subplot(2,2,1)
        stem(out.genOut.t,out.genOut.y);
        grid("on");
        xlim([0 tEnd]);
        ylabel("out");
        xlabel("t");
        title("Generator");
        
        subplot(2,2,2)
        stem(out.srvOut.t,out.srvOut.y);
        grid("on");
        xlim([0 tEnd]);
        ylabel("out");
        xlabel("t");
        title("Server");
        
        subplot(2,2,3)
        stairs(out.srvnOut.t,out.srvnOut.y);
        grid("on");
        xlim([0 tEnd]);
        ylim([0, 1.1])
        ylabel("nS");
        xlabel("t");
        title("Server Load");
        
        subplot(2,2,4)
        plot(out.utilOut.t,out.utilOut.y, '*-');
        grid("on");
        xlim([0 tEnd]);
        ylabel("util");
        xlabel("t");
        title("Server Utilization");
    end
    
end
