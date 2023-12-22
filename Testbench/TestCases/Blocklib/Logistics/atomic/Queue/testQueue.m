function [out] = testQueue()

    tEnd = 12;
    model_generator("Queue_Model");
	out = model_simulator("Queue_Model", tEnd);

    if 0
        % plot results
        figure("name", "testQueue", "NumberTitle", "off")
        subplot(2,2,1)
        stem(out.genOut.t,out.genOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Generator");
        
        subplot(2,2,2)
        plot_ieee1164(out.vgenOut.t, out.vgenOut.y);
		xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("in");
        title("Blocking");
        
        subplot(2,2,3)
        stem(out.queOut.t,out.queOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Queue");
        
        subplot(2,2,4)
        stairs(out.queNOut.t,out.queNOut.y); grid on;
        hold("on");plot(out.queNOut.t,out.queNOut.y, "*");hold("off");
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("nq");
        title("Queue");
    end
end