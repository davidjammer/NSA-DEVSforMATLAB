function [out] = test_cm_carry_ripple_adder_8bit()

    tEnd = 15;
	model_generator("Carry_ripple_adder_8bit_Model");
	out = model_simulator("Carry_ripple_adder_8bit_Model", tEnd);


    if 0
        figure("name", "testcarryrippleadder", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        stairs(out.gen1Out.t,out.gen1Out.y,'-*');
        title("a");
        xlim([0,16])
        ylim([0,20])
        
        subplot(5,1,2)
        stairs(out.gen2Out.t,out.gen2Out.y,'-*');
        title("b");
        xlim([0,16])
        ylim([0,270])
        
        subplot(5,1,3)
        plot_ieee1164(out.gen3Out.t, out.gen3Out.y);
        title("c");
        xlim([0,16])
        
        subplot(5,1,4)
        stairs(out.addersOut.t,out.addersOut.y,'-*');
        title("Adder s");
        xlim([0,16])
        ylim([0,270])
        
        subplot(5,1,5)
        plot_ieee1164(out.addercOut.t, out.addercOut.y);
        title("Adder c");
        xlim([0,16])
    end
end