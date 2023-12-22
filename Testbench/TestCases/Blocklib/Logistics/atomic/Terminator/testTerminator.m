function [out] = testTerminator()
    tEnd = 100;

    model_generator("Terminator_Model");
	out = model_simulator("Terminator_Model", tEnd);

    if 0
        figure("name", "testTerminator", "NumberTitle", "off")
        
        subplot(1,1,1)
        stem(out.termOut.t,out.termOut.y); grid on;
        xlim([0 100]);
        ylim([0 30]);
        xlabel("t");
        ylabel("term out");
    end
    
end