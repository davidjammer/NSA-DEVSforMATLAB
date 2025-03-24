function [out] = test_cm_Mux2to1(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 30;
	model_generator("Mux2to1_Model");
	out = model_simulator("Mux2to1_Model", tEnd);

    if showPlot
        figure("name", "testMux2to1", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("in1");
        xlim([0,tEnd])
        
        subplot(5,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("in2");
        xlim([0,tEnd])
        
        subplot(5,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("sel");
        xlim([0,tEnd])
        
        subplot(5,1,4)
        plot_ieee1164(out.muxOut.t, out.muxOut.y);
        title("q");
        xlim([0,tEnd])
    end
end


