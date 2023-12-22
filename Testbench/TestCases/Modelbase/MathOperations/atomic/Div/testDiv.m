function [out] = testDiv()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

 
	tend = 11.9;

    
    tVec1 = [1, 3, 5, 7,   9];
    yVec1 = [2, 3, 2, 5,   7];
    tVec2 = [1, 3, 5, 7.3, 9.3, 10.0];
    yVec2 = [1, 2, 3, 6,   7,   0];
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Div = devs(am_div("div", [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut],mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut],mdebug));
    Divout = devs(am_toworkspace("Divout", "divOut", 0, "vector", [0, rOut],mdebug));

    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Div);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Divout);

    N1.add_coupling("Vectorgen1","out","div","in1");
    N1.add_coupling("Vectorgen2","out","div","in2");
    N1.add_coupling("Add2","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("div","out","Divout","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();
    out = simout;

    if 0
        figure("name", "testDiv", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(3,1,1)
        stem(simout.gen1Out.t,simout.gen1Out.y);
        title("Generator 1");
        xlim([0,12])
        ylim([0,8])
    
        subplot(3,1,2)
        stem(simout.gen2Out.t,simout.gen2Out.y);
        title("Generator 2");
        xlim([0,12])
        ylim([0,8])
    
        subplot(3,1,3)
        stem(simout.divOut.t,simout.divOut.y);
        xlim([0,12])
        title("Div");
    end
end
