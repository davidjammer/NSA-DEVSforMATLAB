function [out]= testCollect4(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tend = 15;
	model_generator("Collect4_Model");
	out = model_simulator("Collect4_Model", tend);

    if showPlot
        figure("name", "testCollect4", "NumberTitle", "off", ...
	     "Position", [1 1 450 500]);
        subplot(5,1,1)
        stem(out.gen1Out.t,out.gen1Out.y);
        title("Generator 1");
        xlim([0,16])
    
        subplot(5,1,2)
        stem(out.gen2Out.t,out.gen2Out.y);
        title("Generator 2");
        xlim([0,16])
    
        subplot(5,1,3)
        stem(out.gen3Out.t,out.gen3Out.y);
        title("Generator 3");
        xlim([0,16])
	    
        subplot(5,1,4)
        stem(out.gen4Out.t,out.gen4Out.y);
        title("Generator 4");
        xlim([0,16])

        subplot(5,1,5)
        stem(out.combOut.t,out.combOut.y);
        title("Collect4");
        xlim([0,16])
    end

    out = out;
end





