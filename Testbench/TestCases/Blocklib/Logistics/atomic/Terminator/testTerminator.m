function [out] = testTerminator(showPlot)
	if nargin == 0
      showPlot = false;
    end

    tEnd = 100;

    model_generator("Terminator_Model");
	out = model_simulator("Terminator_Model", tEnd);

    if showPlot
        figure("name", "testTerminator", "NumberTitle", "off")
        
        subplot(1,1,1)
        stem(out.termOut.t,out.termOut.y); grid on;
        xlim([0 100]);
        ylim([0 30]);
        xlabel("t");
        ylabel("term out");
    end
    
end