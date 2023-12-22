function [out] = test_am_jk_flip_flop()
    
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.000;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec1 = [0, 0.9, 1.1, 4.9,   15, 16.1, 16.3, 16.9, 17.1,   26];
    yVec1 = ["0",   "1",   "0",   "1",    "0",    "1",    "0",    "1",    "0",    "0"];
    tVec2 = [0, 2.9, 3.1, 4.9,   15, 15.1, 17.3, 17.5, 18.1, 18.5, 20.9, 21.1, 26];
    yVec2 = ["0",   "1",   "0",   "1",    "0",    "0",    "1",    "0",    "1",    "0",    "1",    "0",  "0"];
    
    
    tVec3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
    yVec3 = ["0", "1", "0", "1", "0", "1", "0", "1", "0", "1",  "0",  "1",  "0",  "1",  "0",  "1",  "0",  "1",  "0"];
    tEnd = 30;%50;
    mdebug = false;
    rOut = 1.0;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Vectorgen3 = devs(am_vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
    D = devs(am_jk_flip_flop("JKFF", "0", [0, 1], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
    Doutq = devs(am_toworkspace("Doutq", "doutq", 0, "vector", [0, rOut], mdebug));
    Doutqn = devs(am_toworkspace("Doutqn", "doutqn", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Vectorgen3);
    N1.add_model(D);
    N1.add_model(Gen3out);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Doutq);
    N1.add_model(Doutqn);
    
    N1.add_coupling("Vectorgen1","out","JKFF","j");
    N1.add_coupling("Vectorgen2","out","JKFF","k");
    N1.add_coupling("Vectorgen3","out","JKFF","clk");
    
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("Vectorgen3","out","Gen3out","in");
    N1.add_coupling("JKFF","q","Doutq","in");
    N1.add_coupling("JKFF","qb","Doutqn","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if 0
        figure("name", "testJKFlipFlop", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        plot_ieee1164(simout.gen1Out.t, simout.gen1Out.y);
        title("j");
        xlim([0,tEnd])
        
        subplot(5,1,2)
        plot_ieee1164(simout.gen2Out.t, simout.gen2Out.y);
        title("k");
        xlim([0,tEnd])
        
        subplot(5,1,3)
        plot_ieee1164(simout.gen3Out.t, simout.gen3Out.y);
        title("c");
        xlim([0,tEnd])
        
        subplot(5,1,4)
        plot_ieee1164(simout.doutq.t, simout.doutq.y);
        title("q");
        xlim([0,tEnd])
        
        subplot(5,1,5)
        plot_ieee1164(simout.doutqn.t, simout.doutqn.y);
        title("qn");
        xlim([0,tEnd])
    end
end