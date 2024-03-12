function [out] = test_cm_queue_server(showPlot)
	if nargin == 0
      showPlot = false;
    end
    
    tEnd = 100;
	model_generator("Queue_server_Model");
	out = model_simulator("Queue_server_Model", tEnd);

    if showPlot
        figure("name", "testQueueServer", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        stem(out.genout.t,out.genout.y,'-*');
        title("Generator out");
        xlim([0,tEnd])
        
		subplot(5,1,2)
        stairs(out.nq.t,out.nq.y,'-*');
        title("nq");
        xlim([0,tEnd])

		subplot(5,1,3)
        stairs(out.nqs.t,out.nqs.y,'-*');
        title("nqs");
        xlim([0,tEnd])

		subplot(5,1,4)
        stairs(out.srvout.t,out.srvout.y,'-*');
        title("Server out");
        xlim([0,tEnd])

		subplot(5,1,5)
        stairs(out.nout.t,out.nout.y,'-*');
        title("N out");
        xlim([0,tEnd])
    end
end