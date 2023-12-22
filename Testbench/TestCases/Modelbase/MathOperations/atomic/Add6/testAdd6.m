function [out] = testAdd6()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

 
	tend = 11.9;

    
    tVec1 = [1, 3, 5, 7, 9];
    yVec1 = [2, 3, 2, 5, 7];
    tVec2 = [1, 3, 5, 7.3, 9.3];
    yVec2 = [1, 2, 3, 6, 7];
    tVec3 = [1.5, 1.7, 5, 7, 9.1];
    yVec3 = [3,   2.1, 6, 6, 5];
    tVec4 = [1.5, 3.5, 5.5, 7.5, 9.5];
    yVec4 = [2, 3, 2, 5, 7];
    tVec5 = [1.75, 3.75, 5.75, 7.75, 9.75];
    yVec5 = [2, 3, 2, 5, 7];
    tVec6 = [1.8, 3.8, 5.8, 7.8, 9.8];
    yVec6 = [2, 3, 2, 5, 7];
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Vectorgen3 = devs(am_vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
    Vectorgen4 = devs(am_vectorgen("Vectorgen4", tVec4, yVec4, [0, 1], mdebug));
    Vectorgen5 = devs(am_vectorgen("Vectorgen5", tVec5, yVec5, [0, 1], mdebug));
    Vectorgen6 = devs(am_vectorgen("Vectorgen6", tVec6, yVec6, [0, 1], mdebug));
    Add6 = devs(am_add6("Add6", [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
    Gen4out = devs(am_toworkspace("Gen4out", "gen4Out", 0, "vector", [0, rOut], mdebug));
    Gen5out = devs(am_toworkspace("Gen5out", "gen5Out", 0, "vector", [0, rOut], mdebug));
    Gen6out = devs(am_toworkspace("Gen6out", "gen6Out", 0, "vector", [0, rOut], mdebug));
    Addout = devs(am_toworkspace("Addout", "addOut", 0, "vector", [0, rOut], mdebug));

    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Vectorgen3);
    N1.add_model(Vectorgen4);
    N1.add_model(Vectorgen5);
    N1.add_model(Vectorgen6);
    N1.add_model(Add6);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Gen3out);
    N1.add_model(Gen4out);
    N1.add_model(Gen5out);
    N1.add_model(Gen6out);
    N1.add_model(Addout);

    N1.add_coupling("Vectorgen1","out","Add6","in1");
    N1.add_coupling("Vectorgen2","out","Add6","in2");
    N1.add_coupling("Vectorgen3","out","Add6","in3");
    N1.add_coupling("Vectorgen4","out","Add6","in4");
    N1.add_coupling("Vectorgen5","out","Add6","in5");
    N1.add_coupling("Vectorgen6","out","Add6","in6");
    N1.add_coupling("Add6","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("Vectorgen3","out","Gen3out","in");
    N1.add_coupling("Vectorgen4","out","Gen4out","in");
    N1.add_coupling("Vectorgen5","out","Gen5out","in");
    N1.add_coupling("Vectorgen6","out","Gen6out","in");
    N1.add_coupling("Add6","out","Addout","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();
    out = simout;

    if 0
        figure("name", "testAdd6", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(7,1,1)
        stem(simout.gen1Out.t,simout.gen1Out.y);
        title("Generator 1");
        xlim([0,12])
        ylim([0,8])
    
        subplot(7,1,2)
        stem(simout.gen2Out.t,simout.gen2Out.y);
        title("Generator 2");
        xlim([0,12])
        ylim([0,8])
    
        subplot(7,1,3)
        stem(simout.gen3Out.t,simout.gen3Out.y);
        title("Generator 3");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,4)
        stem(simout.gen4Out.t,simout.gen4Out.y);
        title("Generator 4");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,5)
        stem(simout.gen5Out.t,simout.gen5Out.y);
        title("Generator 5");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,6)
        stem(simout.gen6Out.t,simout.gen6Out.y);
        title("Generator 6");
        xlim([0,12])
        ylim([0,8])

        subplot(7,1,7)
        stem(simout.addOut.t,simout.addOut.y);
        xlim([0,12])
        title("Add6");
    end
end
