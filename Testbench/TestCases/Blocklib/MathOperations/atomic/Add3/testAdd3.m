function [out] = testAdd3()
 
	tend = 11.9;
	model_generator("Add3_Model");
	out = model_simulator("Add3_Model", tend);


    if 0
        figure("name", "testAdd3", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(4,1,1)
        stem(out.gen1Out.t,out.gen1Out.y);
        title("Generator 1");
        xlim([0,12])
        ylim([0,8])
    
        subplot(4,1,2)
        stem(out.gen2Out.t,out.gen2Out.y);
        title("Generator 2");
        xlim([0,12])
        ylim([0,8])
    
        subplot(4,1,3)
        stem(out.gen3Out.t,out.gen3Out.y);
        title("Generator 3");
        xlim([0,12])
        ylim([0,8])

        subplot(4,1,4)
        stem(out.addOut.t,out.addOut.y);
        xlim([0,12])
        title("Add3");
    end
end
