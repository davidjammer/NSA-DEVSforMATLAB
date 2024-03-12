function [out]=testGain(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 17;
	model_generator("Gain_Model"); 
	out = model_simulator("Gain_Model", tEnd);

    if showPlot
        figure("Position",[1 1 450 500]);
        subplot(2,1,1)
        stairs(out.genOut.t,out.genOut.y);
        hold("on");plot(out.genOut.t,out.genOut.y, "*");hold("off");
        grid("on");
        xlim([0, tEnd])
        ylim([-3.2, 2.2])
        xlabel("simulation time");
        ylabel("out");
        title("VectorGen");
        
        subplot(2,1,2)
        stairs(out.gainOut.t,out.gainOut.y);
        hold("on");plot(out.gainOut.t,out.gainOut.y, "*");hold("off");
        grid("on");
        xlim([0, tEnd])
        ylim([-6.4, 4.4])
        xlabel("simulation time");
        ylabel("out");
        title("Gain");
    end

end