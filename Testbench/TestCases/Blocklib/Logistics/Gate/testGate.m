function [out] = testGate(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 19;
	model_generator("Gate_Model");
	out = model_simulator("Gate_Model", tEnd);
    
    if showPlot
        figure("name", "testGate", "NumberTitle", "off")
        subplot(3,1,1)
		    stairs(out.bingenOut.t, out.bingenOut.y);
        xlim([0 tEnd]);
        xlabel("t");
        ylabel("open");
        
        subplot(3,1,2)
        stem(out.genOut.t,out.genOut.y); grid on;
        xlim([0 tEnd]);
        ylim([0 21]);
        xlabel("t");
        ylabel("gen out");

        subplot(3,1,3)
        stem(out.gateOut.t,out.gateOut.y); grid on;
        xlim([0 tEnd]);
        ylim([0 21]);
        xlabel("t");
        ylabel("gate out");
    end
    
end