function [out] = testBingenerator(showPlot)
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
	
	tend = 14;
 
    s0 = true;
    tVec = [2, 4, 7.5, 8.5];
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator('N1');

    Bingenerator = devs(am_bingenerator("Bingenerator", s0, tVec, [0,1], mdebug));
    Terminator = devs(am_terminator("Terminator", [0,rOut], mdebug));
    Binout = devs(am_toworkspace("Binout", "binOut", 0, "vector", [0,rOut], mdebug));

    N1.add_model(Bingenerator);
    N1.add_model(Terminator);
    N1.add_model(Binout);

    N1.add_coupling("Bingenerator","out","Terminator","in");
    N1.add_coupling("Bingenerator","out","Binout","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();
    out = simout;

    if showPlot
        figure("name", "testBingenerator", "NumberTitle", "off")
		plot_ieee1164(simout.binOut.t, simout.binOut.y);
        grid("on");
        xlabel("simulation time");
        ylabel("out");
        title("Bingenerator");
        xlim([0, tend])
    end
end