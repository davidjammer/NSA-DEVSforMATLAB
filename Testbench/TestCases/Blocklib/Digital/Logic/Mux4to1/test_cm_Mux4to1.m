function [out] = test_cm_Mux4to1(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 100;
	model_generator("Mux4to1_Model");
	out = model_simulator("Mux4to1_Model", tEnd);

    if showPlot
        figure("name", "testMux4to1", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(7,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("in1");
        xlim([0,tEnd])
        
        subplot(7,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("in2");
        xlim([0,tEnd])
        
        subplot(7,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("in3");
        xlim([0,tEnd])
        
        subplot(7,1,4)
        plot_ieee1164(out.gen4Out.t, out.gen4Out.y);
        title("in4");
        xlim([0,tEnd])
        
        subplot(7,1,5)
        plot_ieee1164(out.gen5Out.t, out.gen5Out.y);
        title("sel1");
        xlim([0,tEnd])
        
        subplot(7,1,6)
        plot_ieee1164(out.gen6Out.t, out.gen6Out.y);
        title("sel2");
        xlim([0,tEnd])
        
        subplot(7,1,7)
        plot_ieee1164(out.muxOut.t, out.muxOut.y);
        title("q");
        xlim([0,tEnd])
    end
end
