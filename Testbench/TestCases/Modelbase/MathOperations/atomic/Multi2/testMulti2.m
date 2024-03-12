function [out] = testMulti2(showPlot)
	if nargin == 0
      showPlot = false;
    end

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
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Multi2 = devs(am_multi2("Multi2", [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut],mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut],mdebug));
    Multiout = devs(am_toworkspace("Multiout", "multiOut", 0, "vector", [0, rOut],mdebug));

    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Multi2);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Multiout);

    N1.add_coupling("Vectorgen1","out","Multi2","in1");
    N1.add_coupling("Vectorgen2","out","Multi2","in2");
    N1.add_coupling("Multi2","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("Multi2","out","Multiout","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();
    out = simout;

    if showPlot
        figure("name", "testMulti2", "NumberTitle", "off", "Position", [1 1 450 500]);
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
        stem(simout.multiOut.t,simout.multiOut.y);
        xlim([0,12])
        title("Multi2");
    end
end
