function [out] = testhIntegrator(tend)
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    if(nargin ~= 1)
	   tend = 10;
    end
    
    tVec1 = [0, 1, 2, 3, 3.5, 4.5];
    yVec1 = [0, 2, -2, 0, -10, 0];
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    hInt = devs(hIntegrator("hInt", [0, 1], mdebug, 0.01, 0.001));
    Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
    Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
    hIntout = devs(toworkspace("hIntout", "hIntOut", 0, [0, rOut]));

    N1.add_model(Vectorgen1);
    N1.add_model(hInt);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(hIntout);

    N1.add_coupling("Vectorgen1","out","hInt","in");
    N1.add_coupling("hInt","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("hInt","out","hIntout","in");

    root = rootcoordinator("root",0,tend,N1,0);
    root.sim();

    figure
    stairs(simout.gen1Out.t,simout.gen1Out.y); hold on;
    stairs(simout.hIntOut.t,simout.hIntOut.y); hold off;
    
    out = simout;
end
