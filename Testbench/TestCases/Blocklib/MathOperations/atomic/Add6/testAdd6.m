function [out] = testAdd6(showPlot)
	if nargin == 0
      showPlot = false;
    end

	tend = 11.9;
    model_generator("Add6_Model");
	out = model_simulator("Add6_Model", tend);

    if showPlot
        figure("name", "testAdd6", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(7,1,1)
        stem(out.gen1Out.t,out.gen1Out.y);
        title("Generator 1");
        xlim([0,12])
        ylim([0,8])
    
        subplot(7,1,2)
        stem(out.gen2Out.t,out.gen2Out.y);
        title("Generator 2");
        xlim([0,12])
        ylim([0,8])
    
        subplot(7,1,3)
        stem(out.gen3Out.t,out.gen3Out.y);
        title("Generator 3");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,4)
        stem(out.gen4Out.t,out.gen4Out.y);
        title("Generator 4");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,5)
        stem(out.gen5Out.t,out.gen5Out.y);
        title("Generator 5");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,6)
        stem(out.gen6Out.t,out.gen6Out.y);
        title("Generator 6");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,7)
        stem(out.addOut.t,out.addOut.y);
        xlim([0,12])
        title("Add6");
    end
end
