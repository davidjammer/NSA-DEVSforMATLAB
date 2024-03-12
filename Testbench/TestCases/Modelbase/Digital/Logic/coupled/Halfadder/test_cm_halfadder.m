function [out] = test_cm_halfadder(showPlot)
	if nargin == 0
      showPlot = false;
    end

    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.000;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec1 = [1,    2,   3,   6,   7,   8,  10];
    yVec1 = ["0", "1", "0", "1", "0", "1", "0"];
    tVec2 = [1,    4,   5,   6,   7,   9,  10];
    yVec2 = ["0", "1", "0", "1", "0", "1", "0"];
    tEnd = 15;
    mdebug = false;
    rOut = 1.0;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Ha = cm_halfadder("ha", [0, 1], mdebug);
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Terminator2 = devs(am_terminator("Terminator2", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    HaSout = devs(am_toworkspace("HaSout", "hasOut", 0, "vector", [0, rOut], mdebug));
    HaCout = devs(am_toworkspace("HaCout", "hacOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Ha);
    N1.add_model(Terminator1);
    N1.add_model(Terminator2);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(HaSout);
    N1.add_model(HaCout);
    
    N1.add_coupling("Vectorgen1","out","ha","in1");
    N1.add_coupling("Vectorgen2","out","ha","in2");
    N1.add_coupling("ha","s","Terminator1","in");
    N1.add_coupling("ha","c","Terminator2","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("ha","s","HaSout","in");
    N1.add_coupling("ha","c","HaCout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if showPlot
        figure("name", "testhalfadder", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(4,1,1)
        plot_ieee1164(simout.gen1Out.t, simout.gen1Out.y);
        title("Generator 1");
        xlim([0,16])
        
        subplot(4,1,2)
        plot_ieee1164(simout.gen2Out.t, simout.gen2Out.y);
        title("Generator 2");
        xlim([0,16])
        
        subplot(4,1,3)
        plot_ieee1164(simout.hasOut.t, simout.hasOut.y);
        title("s");
        xlim([0,16])
        
        subplot(4,1,4)
        plot_ieee1164(simout.hacOut.t, simout.hacOut.y);
        title("c");
        xlim([0,16])
    end
end