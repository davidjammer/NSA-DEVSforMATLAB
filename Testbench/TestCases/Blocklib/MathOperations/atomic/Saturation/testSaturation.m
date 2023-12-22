function [out]=testSaturation()

    tEnd = 17;
	model_generator("Saturation_Model");
	out = model_simulator("Saturation_Model", tEnd);

    if 0
        figure("name", "testSaturation", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(2,1,1)
        stem(out.genOut.t,out.genOut.y);
        title("Generator");
        xlim([0,tEnd])
        ylim([-5,5])
    
        subplot(2,1,2)
        stem(out.saturationOut.t,out.saturationOut.y);
        title("Saturation");
        xlim([0,tEnd])
        ylim([-5,5])
    end

end