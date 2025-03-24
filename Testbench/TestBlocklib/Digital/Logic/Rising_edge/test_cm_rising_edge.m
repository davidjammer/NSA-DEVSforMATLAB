function [out] = test_cm_rising_edge(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 15;
	model_generator("CMRising_edge_Model");
	out = model_simulator("CMRising_edge_Model", tEnd);

    if showPlot
        figure("name", "test rising edge", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(2,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("in");
        xlim([0,16])
        
        subplot(2,1,2)
        plot_ieee1164(out.reOut.t, out.reOut.y);
        title("re");
        xlim([0,16])
    end
end
