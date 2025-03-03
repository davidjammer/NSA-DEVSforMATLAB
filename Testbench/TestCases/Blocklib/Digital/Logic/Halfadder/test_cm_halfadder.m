function [out] = test_cm_halfadder(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 15;
	model_generator("Halfadder_Model");
	out = model_simulator("Halfadder_Model", tEnd);

    if showPlot
        figure("name", "testhalfadder", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(4,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("Generator 1");
        xlim([0,16])
        
        subplot(4,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("Generator 2");
        xlim([0,16])
        
        subplot(4,1,3)
        plot_ieee1164(out.hasOut.t, out.hasOut.y);
        title("s");
        xlim([0,16])
        
        subplot(4,1,4)
        plot_ieee1164(out.hacOut.t, out.hacOut.y);
        title("c");
        xlim([0,16])
    end
end