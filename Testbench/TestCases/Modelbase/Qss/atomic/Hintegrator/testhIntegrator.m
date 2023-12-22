function [out] = testhIntegrator()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

	tend = 10;
    
    tVec1 = [0, 1, 2, 3, 3.5, 4.5];
    yVec1 = [0, 2, -2, 0, -10, 0];
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    hInt = devs(am_hIntegrator("hInt", 0.01, 0.001, 0.0, [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    hIntout = devs(am_toworkspace("hIntout", "hIntOut", 0, "vector", [0, rOut], mdebug));

    N1.add_model(Vectorgen1);
    N1.add_model(hInt);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(hIntout);

    N1.add_coupling("Vectorgen1","out","hInt","in");
    N1.add_coupling("hInt","out","Terminator1","in");
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("hInt","out","hIntout","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();
    out = simout;

    if 0
        figure
        stairs(simout.gen1Out.t,simout.gen1Out.y); hold on;
        stairs(simout.hIntOut.t,simout.hIntOut.y); hold off;
    end
end
