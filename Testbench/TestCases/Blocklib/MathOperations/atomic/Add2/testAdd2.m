function [out] = testAdd2()
 
	tend = 11.9;
    model_generator("Add2_Model");
	out = model_simulator("Add2_Model", tend);
    

    if 0
        figure("name", "testAdd2", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(3,1,1)
        stem(out.gen1Out.t,out.gen1Out.y);
        title("Generator 1");
        xlim([0,12])
        ylim([0,8])
    
        subplot(3,1,2)
        stem(out.gen2Out.t,out.gen2Out.y);
        title("Generator 2");
        xlim([0,12])
        ylim([0,8])
    
        subplot(3,1,3)
        stem(out.addOut.t,out.addOut.y);
        xlim([0,12])
        title("Add2");
    end
end
