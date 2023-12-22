function [out] = test_am_not()

    tEnd = 14;
	model_generator("Not_Model");
	out = model_simulator("Not_Model", tEnd);

    if 0
        figure("name", "testNotgate", "NumberTitle", "off")
        subplot(2,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Gen1");
        xlim([0, tEnd])
        
        subplot(2,1,2)
        plot_ieee1164(out.notOut.t, out.notOut.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Not");
        xlim([0, tEnd])
    end
end