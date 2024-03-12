function [out] = test_cm_nand4(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 30;
	model_generator("CMNand4_Model");
	out = model_simulator("CMNand4_Model", tEnd);
    
    if showPlot
        figure("name", "testNand4", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(6,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("in1");
        xlim([0,tEnd])
        
        subplot(6,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("in2");
        xlim([0,tEnd])
        
        subplot(6,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("in3");
        xlim([0,tEnd])
        
        subplot(6,1,4)
        plot_ieee1164(out.gen4Out.t, out.gen4Out.y);
        title("in4");
        xlim([0,tEnd])
        
        subplot(6,1,5)
        plot_ieee1164(out.nandOut.t, out.nandOut.y);
        title("out");
        xlim([0,tEnd])
    end
end
