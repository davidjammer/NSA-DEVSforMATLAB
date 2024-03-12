function [out] = testMulti2(showPlot)
	if nargin == 0
      showPlot = false;
    end

	tend = 11.9;
	model_generator("Multi2_Model");
	out = model_simulator("Multi2_Model", tend);

    if showPlot
        figure("name", "testMulti2", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(3,1,1)
        stem(out.gen1Out.t,out.gen1Out.y);
        title("Generator 1");
        xlim([0,12])
        ylim([0,8])
    
        subplot(3,1,2)
        stem(out.gen2Out.t,out.gen2Out.y);
        title("Generator 2");
        xlim([0,12])
        ylim([0,8])
    
        subplot(3,1,3)
        stem(out.multiOut.t,out.multiOut.y);
        xlim([0,12])
        title("Multi2");
    end
end
