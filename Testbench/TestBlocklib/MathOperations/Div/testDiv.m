function [out] = testDiv(showPlot)
	if nargin == 0
      showPlot = false;
    end

	tend = 11.9;
	model_generator("Div_Model"); 
	out = model_simulator("Div_Model", tend);

    if showPlot
        figure("name", "testDiv", "NumberTitle", "off", "Position", [1 1 450 500]);
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
        stem(out.divOut.t,out.divOut.y);
        xlim([0,12])
        title("Div");
    end
end
