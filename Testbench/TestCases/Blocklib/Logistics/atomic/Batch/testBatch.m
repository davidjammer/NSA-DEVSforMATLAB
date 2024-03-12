function [out] = testBatch(showPlot)
    if nargin == 0
      showPlot = false;
    end

	global simout
    global epsilon
    global DEBUGLEVEL
    global mi
   
  	tend = 40;
    model_generator("Batch_Model");
    out = model_simulator("Batch_Model", tend);

    if showPlot
        figure('Position',[1 1 550 350])
        subplot(2,1,1)
        stem(out.genOut.t,out.genOut.y); 
        grid("on");
        xlim([0 tend]);
        ylim([0, tend])
        ylabel("out");
        xlabel("t");
        title("Generator");
    
        subplot(2,1,2)
        stairs(out.batch_n.t,out.batch_n.y);
        grid("on");
        xlim([0 tend]);
        ylim([0, max(out.batch_n.y)+1])
        ylabel("nq");
        xlabel("t");
        title("Batch");
        

    end

    out = simout;
end
