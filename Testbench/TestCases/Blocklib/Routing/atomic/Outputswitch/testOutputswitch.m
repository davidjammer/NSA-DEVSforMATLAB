function [out] = testOutputswitch(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 17.5;
	model_generator("Outputswitch_Model");
	out = model_simulator("Outputswitch_Model", tEnd);

    if showPlot
        figure("Position",[1 1 450 600]);
        subplot(4,1,1)
        stairs(out.genOut.t,out.genOut.y);
        hold("on");plot(out.genOut.t,out.genOut.y, "*");hold("off");
        grid("on");
        xlim([0, tEnd])
        ylim([0, 18])
        ylabel("out");
        title("Generator");
        
        subplot(4,1,2)
        plot_ieee1164(out.vgenOut.t,out.vgenOut.y);
        grid("on");
        xlim([0, tEnd])
        ylabel("out");
        title("VectorGen");
        
        subplot(4,1,3)
        stairs(out.sw1Out.t,out.sw1Out.y);
        hold("on");plot(out.sw1Out.t,out.sw1Out.y, "*");hold("off");
        grid("on");
        xlim([0, tEnd])
        ylim([0, 18])
        ylabel("out1");
        title("Switch");
        
        subplot(4,1,4)
        stairs(out.sw2Out.t,out.sw2Out.y);
        hold("on");plot(out.sw2Out.t,out.sw2Out.y, "*");hold("off");
        grid("on");
        xlim([0, tEnd])
        ylim([0, 18])
        ylabel("out2");
        title("Switch");
    end
end