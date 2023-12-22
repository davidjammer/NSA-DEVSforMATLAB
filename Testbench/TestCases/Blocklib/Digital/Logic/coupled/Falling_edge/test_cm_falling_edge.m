function [out] = test_cm_falling_edge()

    tEnd = 15;
	model_generator("Falling_edge_Model");
	out = model_simulator("Falling_edge_Model", tEnd);

    if 0
        figure("name", "test falling edge", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(2,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("in");
        xlim([0,16])
        
        subplot(2,1,2)
        plot_ieee1164(out.feOut.t, out.feOut.y);
        title("fe");
        xlim([0,16])
    end
end
