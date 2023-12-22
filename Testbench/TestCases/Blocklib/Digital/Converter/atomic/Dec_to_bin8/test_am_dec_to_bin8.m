function [out] = test_am_dec_to_bin8()
 
    
    tEnd = 256;
	model_generator("Dec_to_bin8_Model");
	out = model_simulator("Dec_to_bin8_Model", tEnd);

    if 0
        figure("name", "testNand2", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(9,1,1)
        stairs(out.gen1Out.t,out.gen1Out.y,'-*');
        title("Generator 1");
        xlim([0,tEnd])
        ylim([0,260])
        
        subplot(9,1,2)
        plot_ieee1164(out.dectobin8Out0.t, out.dectobin8Out0.y);
        title("bin0");
        xlim([0,tEnd])
        
        subplot(9,1,3)
        plot_ieee1164(out.dectobin8Out1.t, out.dectobin8Out1.y);
        title("bin1");
        xlim([0,tEnd])
        
        subplot(9,1,4)
        plot_ieee1164(out.dectobin8Out2.t, out.dectobin8Out2.y);
        title("bin2");
        xlim([0,tEnd])
        
        subplot(9,1,5)
        plot_ieee1164(out.dectobin8Out3.t, out.dectobin8Out3.y);
        title("bin3");
        xlim([0,tEnd])
        
        subplot(9,1,6)
        plot_ieee1164(out.dectobin8Out4.t, out.dectobin8Out4.y);
        title("bin4");
        xlim([0,tEnd])
        
        subplot(9,1,7)
        plot_ieee1164(out.dectobin8Out5.t, out.dectobin8Out5.y);
        title("bin5");
        xlim([0,tEnd])
        
        subplot(9,1,8)
        plot_ieee1164(out.dectobin8Out6.t, out.dectobin8Out6.y);
        title("bin6");
        xlim([0,tEnd])
        
        subplot(9,1,9)
        plot_ieee1164(out.dectobin8Out7.t, out.dectobin8Out7.y);
        title("bin7");
        xlim([0,tEnd])
    end
end