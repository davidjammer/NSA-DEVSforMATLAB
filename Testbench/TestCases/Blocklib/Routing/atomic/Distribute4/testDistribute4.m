function [out] = testDistribute4()
 
	tend = 25;
	model_generator("Distribute4_Model");
	out = model_simulator("Distribute4_Model", tend);

    if 0
        figure("name", "testDistribute4", "NumberTitle", "off", ...
	     "Position",[1 1 550 575]);
        subplot(4,2,1)
        stem(out.genOut.t,out.genOut.y);
        grid("on");
        xlim([0, tend])
        ylabel("out");
        title("Generator");
    
        subplot(4,2,3)
        stairs(out.vgenOut.t,out.vgenOut.y);
        hold("on");plot(out.vgenOut.t,out.vgenOut.y, "*");hold("off");
        grid("on");
        xlim([0, tend])
        ylim([0.8, 4.2])
        ylabel("out");
        title("Distributor port");
    
        subplot(4,2,2)
        stem(out.dist1Out.t,out.dist1Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out1");
        title("Distributor");
    
        subplot(4,2,4)
        stem(out.dist2Out.t,out.dist2Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out2");
        title("Distributor");
    
        subplot(4,2,6)
        stem(out.dist3Out.t,out.dist3Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out3");
        title("Distributor");

        subplot(4,2,8)
        stem(out.dist4Out.t,out.dist4Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out4");
        title("Distributor");
    end
    
end
