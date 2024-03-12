function [out] = test_am_jk_flip_flop(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 30;%50;
	model_generator("JKFF_Model");
	out = model_simulator("JKFF_Model", tEnd);

    if showPlot
        figure("name", "testJKFlipFlop", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("j");
        xlim([0,tEnd])
        
        subplot(5,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("k");
        xlim([0,tEnd])
        
        subplot(5,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("c");
        xlim([0,tEnd])
        
        subplot(5,1,4)
        plot_ieee1164(out.doutq.t, out.doutq.y);
        title("q");
        xlim([0,tEnd])
        
        subplot(5,1,5)
        plot_ieee1164(out.doutqn.t, out.doutqn.y);
        title("qn");
        xlim([0,tEnd])
    end
end