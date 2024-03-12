function [out] = test_cm_fulladder(showPlot)
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
    
    tVec1 = [1, 2, 3, 6, 7, 8, 9, 12];
    yVec1 = ["0", "1", "0", "1", "0", "1", "0", "1"];
    
    tVec2 = [1, 4, 5, 6, 7, 10, 11, 12];
    yVec2 = ["0", "1", "0", "1", "0", "1",  "0",  "1"];
    
    tVec3 = [1, 4, 5, 6, 7, 12];
    yVec3 = ["0", "0", "0", "0", "1", "1"];
    
    tEnd = 15;
    mdebug = false;
    rOut = 10.0;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Vectorgen3 = devs(am_vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
    Fa = cm_fulladder("fa", [0, 1], mdebug);
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Terminator2 = devs(am_terminator("Terminator2", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
    FaSout = devs(am_toworkspace("FaSout", "fasOut", 0, "vector", [0, rOut], mdebug));
    FaCout = devs(am_toworkspace("FaCout", "facOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Vectorgen3);
    N1.add_model(Fa);
    N1.add_model(Terminator1);
    N1.add_model(Terminator2);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Gen3out);
    N1.add_model(FaSout);
    N1.add_model(FaCout);
    
    N1.add_coupling("Vectorgen1","out","fa","in1");
    N1.add_coupling("Vectorgen2","out","fa","in2");
    N1.add_coupling("Vectorgen3","out","fa","in3");
    N1.add_coupling("fa","s","Terminator1","in");
    N1.add_coupling("fa","c","Terminator2","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("Vectorgen3","out","Gen3out","in");
    N1.add_coupling("fa","s","FaSout","in");
    N1.add_coupling("fa","c","FaCout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;
    
    if showPlot
        figure("name", "testfulladder", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        plot_ieee1164(simout.gen1Out.t, simout.gen1Out.y);
        title("Generator 1");
        xlim([0,16])
        
        subplot(5,1,2)
        plot_ieee1164(simout.gen2Out.t, simout.gen2Out.y);
        title("Generator 2");
        xlim([0,16])
        
        subplot(5,1,3)
        plot_ieee1164(simout.gen3Out.t, simout.gen3Out.y);
        title("Generator 3");
        xlim([0,16])
        
        subplot(5,1,4)
        plot_ieee1164(simout.fasOut.t, simout.fasOut.y);
        title("s");
        xlim([0,16])
        
        subplot(5,1,5)
        plot_ieee1164(simout.facOut.t, simout.facOut.y);
        title("c");
        xlim([0,16])
    end
end