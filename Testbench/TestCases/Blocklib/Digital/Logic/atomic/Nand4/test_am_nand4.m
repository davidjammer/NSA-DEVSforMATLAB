function out = test_am_nand4()

    tEnd = 30;
	model_generator("Nand4_Model");
	out = model_simulator("Nand4_Model", tEnd);
    
    if 0
        figure("name", "testNand4", "NumberTitle", "off", "Position", [1 1 450 400]);
        subplot(5,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("A");
        xlim([0,tEnd])
        xlabel('t');
        grid on;
        
        subplot(5,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("B");
        xlim([0,tEnd])
        xlabel('t');
        grid on;
        
        subplot(5,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("C");
        xlim([0,tEnd])
        xlabel('t');
        grid on;

        subplot(5,1,4)
        plot_ieee1164(out.gen4Out.t, out.gen4Out.y);
        title("D");
        xlim([0,tEnd])
        xlabel('t');
        grid on;

        subplot(5,1,5)
        plot_ieee1164(out.nandOut.t, out.nandOut.y);
        title("Y");
        xlim([0,tEnd])
        xlabel('t');
        grid on;
    end   
end