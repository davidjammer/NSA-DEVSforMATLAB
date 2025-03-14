function out = test_am_nand3(showPlot)
	if nargin == 0
      showPlot = false;
    end

    global simout
    global epsilon
    global DEBUGLEVEL
    global mu
    mu = 0.000;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
    yVec1 = ["0", "1", "0", "1", "0", "1", "0", "1", "0", "1",  "0",  "1",  "0",  "1", "0",  "1",  "0"];
    tVec2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
    yVec2 = ["0", "0", "1", "1", "0", "0", "1", "1", "0", "0",  "1",  "1",  "0",  "0",  "1",  "1",  "0"];
    tVec3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
    yVec3 = ["0", "0", "0", "0", "1", "1", "1", "1", "0", "0",  "0",  "0",  "1",  "1",  "1",  "1",  "0"];
    tEnd = 15;
    mdebug = false;
    rOut = 1.0;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Vectorgen3 = devs(am_vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
    Nand3 = devs(am_nand3("Nand3", [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
    Nandout = devs(am_toworkspace("Nandout", "nandOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Vectorgen3);
    N1.add_model(Nand3);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Gen3out);
    N1.add_model(Nandout);
    
    N1.add_coupling("Vectorgen1","out","Nand3","in1");
    N1.add_coupling("Vectorgen2","out","Nand3","in2");
    N1.add_coupling("Vectorgen3","out","Nand3","in3");
    N1.add_coupling("Nand3","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("Vectorgen3","out","Gen3out","in");
    N1.add_coupling("Nand3","out","Nandout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;
    
    if showPlot
        figure("name", "testNand3", "NumberTitle", "off", "Position", [1 1 450 400]);
        subplot(4,1,1)
        plot_ieee1164(simout.gen1Out.t, simout.gen1Out.y);
        title("A");
        xlim([0,16])
        xlabel('t');
        grid on;
        
        subplot(4,1,2)
        plot_ieee1164(simout.gen2Out.t, simout.gen2Out.y);
        title("B");
        xlim([0,16])
        xlabel('t');
        grid on;
        
        subplot(4,1,3)
        plot_ieee1164(simout.gen3Out.t, simout.gen3Out.y);
        title("C");
        xlim([0,16])
        xlabel('t');
        grid on;

        subplot(4,1,4)
        plot_ieee1164(simout.nandOut.t, simout.nandOut.y);
        title("Y");
        xlim([0,16])
        xlabel('t');
        grid on;
    end   
end