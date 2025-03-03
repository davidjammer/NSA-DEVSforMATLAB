function [out] = test_cm_not(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 14;
	model_generator("CMNot_Model");
	out = model_simulator("CMNot_Model", tEnd);

    if showPlot
        figure("name", "testNotgate", "NumberTitle", "off")
        subplot(2,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Gen1");
        xlim([0, tEnd])
        
        subplot(2,1,2)
        plot_ieee1164(out.notOut.t, out.notOut.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Not");
        xlim([0, tEnd])
    end
end