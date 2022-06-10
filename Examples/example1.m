function [out] = example1(tend)
    % example from NSA simulator article to test simulator and graphic output
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 1;           % simulator debug level
    epsilon = 1e-6;

    if(nargin ~= 1)
	   tend = 1.5;
    end
    
    tVec = [1, 2, 3, 4];
    yVec = tVec/10;
    g = 3;
    mdebug = false;

    N1 = coordinator("N");

    Vectorgen = devs(vectorgen("G", tVec, yVec, [0, 1], mdebug));
    Gain = devs(gain("M", g, [0, 1], mdebug));
    Terminator1 = devs(terminator("T", [0, 1], mdebug));

    N1.add_model(Vectorgen);
    N1.add_model(Gain);
    N1.add_model(Terminator1);

    N1.add_coupling("G","out","M","in");
    N1.add_coupling("M","out","T","in");

    root = rootcoordinator("root",0,tend,N1,0);
    root.sim();

    disp("ready")
   
    out = simout;
end
