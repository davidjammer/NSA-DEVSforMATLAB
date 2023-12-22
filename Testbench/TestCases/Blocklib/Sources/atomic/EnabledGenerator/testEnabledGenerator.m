function [out] = testEnabledGenerator()

    tEnd = 19;
	model_generator("EnabledGenerator_Model");
	out = model_simulator("EnabledGenerator_Model", tEnd);
    
    if 0
        figure("name", "testEnabledGenerator", "NumberTitle", "off")
        subplot(2,1,1)
		plot_ieee1164(out.bingenOut.t, out.bingenOut.y);
        xlim([0 tEnd]);
        xlabel("t");
        ylabel("enable");
        
        subplot(2,1,2)
        stem(out.genOut.t,out.genOut.y); grid on;
        xlim([0 tEnd]);
        ylim([0 15]);
        xlabel("t");
        ylabel("gen out");
    end
    
end