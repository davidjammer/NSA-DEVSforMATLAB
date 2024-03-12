function [out] = test_am_bin_to_double(showPlot)
	if nargin == 0
      showPlot = false;
    end
    
    tEnd = 10;
	model_generator("bin_to_double_Model");
	out = model_simulator("bin_to_double_Model", tEnd);

    if showPlot
        figure("name", "testNand2", "NumberTitle", "off", "Position", [1 1 450 500]);
        
        
        subplot(2,1,1)
        plot_ieee1164(out.gen1out.t, out.gen1out.y);
        title("Genout");
        xlim([0,tEnd])

		subplot(2,1,2)
        stairs(out.convout.t,out.convout.y,'-*');
        title("convout");
        xlim([0,tEnd])
        ylim([0,2])
    end
end