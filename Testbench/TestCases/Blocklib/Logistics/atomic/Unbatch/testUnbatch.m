function [out] = testUnbatch()

    tEnd = 40;
    model_generator("Unbatch_Model");
	out = model_simulator("Unbatch_Model", tEnd);
    
    if 0
        figure
        stem(out.out.t,out.out.y); grid on;
        xlim([0 tEnd]);
        xlabel('simulation time');
        title('unbatch out');
    end
    
end
