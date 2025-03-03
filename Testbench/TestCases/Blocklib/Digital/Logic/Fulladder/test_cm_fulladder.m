function [out] = test_cm_fulladder(showPlot)
    if nargin == 0
      showPlot = false;
    end

    tEnd = 15;
	model_generator("Fulladder_Model");
	out = model_simulator("Fulladder_Model", tEnd);
    
    if showPlot
        figure("name", "testfulladder", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("Generator 1");
        xlim([0,16])
        
        subplot(5,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("Generator 2");
        xlim([0,16])
        
        subplot(5,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("Generator 3");
        xlim([0,16])
        
        subplot(5,1,4)
        plot_ieee1164(out.fasOut.t, out.fasOut.y);
        title("s");
        xlim([0,16])
        
        subplot(5,1,5)
        plot_ieee1164(out.facOut.t, out.facOut.y);
        title("c");
        xlim([0,16])
    end
end