function [out] = test_am_bin_to_double(showPlot)
    if nargin == 0
      showPlot = false;
    end

    global simout
    global epsilon
    global DEBUGLEVEL
    global mu
    mu = 0.001;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec1 = [0,1,2];
    yVec1 = ["0","1","0"];
    
    
    
    tEnd = 10;
    mdebug = false;
    rOut = 1.0;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Converter = devs(am_bin_to_double("converter", [0, 1], mdebug));

    Gen1out = devs(am_toworkspace("Gen1out", "gen1out", 0, "vector", [0, rOut], mdebug));
    Convout = devs(am_toworkspace("Convout", "convout", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen1);
    N1.add_model(Converter);
    N1.add_model(Gen1out);
    N1.add_model(Convout);

    N1.add_coupling("Vectorgen1","out","converter","in");
    
    N1.add_coupling("converter","out","Convout","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");

    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if showPlot
        figure("name", "testNand2", "NumberTitle", "off", "Position", [1 1 450 500]);
        
        
        subplot(2,1,1)
        plot_ieee1164(simout.gen1out.t, simout.gen1out.y);
        title("Genout");
        xlim([0,tEnd])

		subplot(2,1,2)
        stairs(simout.convout.t,simout.convout.y,'-*');
        title("convout");
        xlim([0,tEnd])
        ylim([0,2])
    end
end