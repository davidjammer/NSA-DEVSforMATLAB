function [out] = test_cm_not(showPlot)
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
    
    s0 = 1;
    tVec1 = [0,   1,  2,  3];
    yVec1 = ["0","1","0","1"];
    tEnd = 14;
    mdebug = false;
    rOut = 3.0;
    
    N1 = coordinator('N1');
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Notgate = cm_not("Notgate", [0,1], mdebug);
    Terminator = devs(am_terminator("Terminator", [0,rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0,rOut], mdebug));
    Notout = devs(am_toworkspace("Notout", "notOut", 0, "vector", [0,rOut], mdebug));
    
    N1.add_model(Vectorgen1);
    N1.add_model(Notgate);
    N1.add_model(Terminator);
    N1.add_model(Gen1out);
    N1.add_model(Notout);
    
    N1.add_coupling("Vectorgen1","out","Notgate","in");
    N1.add_coupling("Notgate","out","Terminator","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Notgate","out","Notout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;
    if showPlot
        figure("name", "testNotgate", "NumberTitle", "off")
        subplot(2,1,1)
        plot_ieee1164(simout.gen1Out.t, simout.gen1Out.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Gen1");
        xlim([0, tEnd])
        
        subplot(2,1,2)
        plot_ieee1164(simout.notOut.t, simout.notOut.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Not");
        xlim([0, tEnd])
    end
end