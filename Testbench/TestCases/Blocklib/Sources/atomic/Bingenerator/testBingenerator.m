function [out] = testBingenerator()
	
	tend = 14;
	model_generator("Bingenerator_Model");
	out = model_simulator("Bingenerator_Model", tend);

    if 0
        figure("name", "testBingenerator", "NumberTitle", "off")
		plot_ieee1164(out.binOut.t, out.binOut.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Bingenerator");
        xlim([0, tend])
    end
end