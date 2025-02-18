function [out] = testAdd3(showPlot)
	if nargin == 0
      showPlot = false;
    end

    global simout
    global epsilon
    global DEBUGLEVEL
    global mu
    mu = 0.0;
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
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Vectorgen3 = devs(am_vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
    Add3 = devs(am_add3("Add3", [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
    Addout = devs(am_toworkspace("Addout", "addOut", 0, "vector", [0, rOut], mdebug));

    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Vectorgen3);
    N1.add_model(Add3);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Gen3out);
    N1.add_model(Addout);

    N1.add_coupling("Vectorgen1","out","Add3","in1");
    N1.add_coupling("Vectorgen2","out","Add3","in2");
    N1.add_coupling("Vectorgen3","out","Add3","in3");
    N1.add_coupling("Add3","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("Vectorgen3","out","Gen3out","in");
    N1.add_coupling("Add3","out","Addout","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();
    out = simout;

    if showPlot
        figure("name", "testAdd3", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(4,1,1)
        stem(simout.gen1Out.t,simout.gen1Out.y);
        title("Generator 1");
        xlim([0,12])
        ylim([0,8])
    
        subplot(4,1,2)
        stem(simout.gen2Out.t,simout.gen2Out.y);
        title("Generator 2");
        xlim([0,12])
        ylim([0,8])
    
        subplot(4,1,3)
        stem(simout.gen3Out.t,simout.gen3Out.y);
        title("Generator 3");
        xlim([0,12])
        ylim([0,8])

        subplot(4,1,4)
        stem(simout.addOut.t,simout.addOut.y);
        xlim([0,12])
        title("Add3");
    end
end
