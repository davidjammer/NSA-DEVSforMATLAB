function [out] = testQueue_en()

    tEnd = 200;
    model_generator("Queue_en_Model");
	out = model_simulator("Queue_en_Model", tEnd);

    if 0
        % plot results
        figure("name", "testQueue_en", "NumberTitle", "off")
        subplot(5,1,1)
        stem(out.genOut.t,out.genOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Generator");
        
        subplot(5,1,2)
		plot_ieee1164(out.bingenOut.t, out.bingenOut.y);
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("enable");

        subplot(5,1,3)
        stairs(out.bufferNQ.t,out.bufferNQ.y); grid on;
        xlim([0 tEnd]);
        ylim([0 20]);
        xlabel("simulation time");
        ylabel("NQ");

        subplot(5,1,4)
        stairs(out.srvnOut.t,out.srvnOut.y); grid on;
        hold("on");plot(out.srvnOut.t,out.srvnOut.y, "*");hold("off");
        xlim([0 tEnd]);
        ylim([-0.1, 1.1])
        xlabel("simulation time");
        ylabel("n");
        title("Server");
        
        subplot(5,1,5)
        stem(out.srvOut.t,out.srvOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Server");
    end
end