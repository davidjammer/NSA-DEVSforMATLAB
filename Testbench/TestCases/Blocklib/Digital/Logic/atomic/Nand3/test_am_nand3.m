function out = test_am_nand3()

    tEnd = 15;
	model_generator("Nand3_Model");
	out = model_simulator("Nand3_Model", tEnd);
    
    if 0
        figure("name", "testNand3", "NumberTitle", "off", "Position", [1 1 450 400]);
        subplot(4,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("A");
        xlim([0,16])
        xlabel('t');
        grid on;
        
        subplot(4,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("B");
        xlim([0,16])
        xlabel('t');
        grid on;
        
        subplot(4,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("C");
        xlim([0,16])
        xlabel('t');
        grid on;

        subplot(4,1,4)
        plot_ieee1164(out.nandOut.t, out.nandOut.y);
        title("Y");
        xlim([0,16])
        xlabel('t');
        grid on;
    end   
end