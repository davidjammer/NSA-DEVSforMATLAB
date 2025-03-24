function [out]=testGenerator(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 10;
	model_generator("Generator_Model");
	out = model_simulator("Generator_Model", tEnd);
    
    if showPlot
        figure("name", "testGenerator1", "NumberTitle", "off")
        stem(out.genOut.t,out.genOut.y); grid on;
        xlim([0 tEnd]);
        ylim([0 9]);
        xlabel("simulation time");
        ylabel("out");
        title("testGenerator1");
    end
end