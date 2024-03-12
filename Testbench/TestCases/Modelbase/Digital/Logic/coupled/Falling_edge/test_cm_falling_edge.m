function [out] = test_cm_falling_edge(showPlot)
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
    
    tVec1 = [1, 2, 3, 6];
    yVec1 = ["0", "1", "0", "1"];
    tEnd = 15;
    mdebug = false;
    rOut = 1;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Fe = cm_falling_edge("fe", [0, 1], mdebug);
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Feout = devs(am_toworkspace("Feout", "feOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen1);
    N1.add_model(Fe);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Feout);
    
    N1.add_coupling("Vectorgen1","out","fe","in");
    N1.add_coupling("fe","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("fe","out","Feout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if showPlot
        figure("name", "test falling edge", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(2,1,1)
        plot_ieee1164(simout.gen1Out.t, simout.gen1Out.y);
        title("in");
        xlim([0,16])
        
        subplot(2,1,2)
        plot_ieee1164(simout.feOut.t, simout.feOut.y);
        title("fe");
        xlim([0,16])
    end
end
