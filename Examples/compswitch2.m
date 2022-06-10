function [out] = compswitch2(tend)
    % compswitch1 without output for sequence diagram
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
    
    tVec = [1 2];
    yVec = [1 -2];
    mdebug = false;

    N = coordinator("N");

    Vectorgen = devs(vectorgen("G", tVec, yVec, [0, 1], mdebug));
    Comparator = devs(comparator("C", [0, 1], mdebug));
    Outputswitch = devs(outputswitch("S", 1, [0, 1], mdebug));
    Terminator1 = devs(terminator("T1", [0, 1], mdebug));
    Terminator2 = devs(terminator("T2", [0, 1], mdebug));

    N.add_model(Vectorgen);
    N.add_model(Comparator);
    N.add_model(Outputswitch);
    N.add_model(Terminator1);
    N.add_model(Terminator2);

    N.add_coupling("G","out","C","in");
    N.add_coupling("G","out","S","in");
    N.add_coupling("C","out","S","sw");
    N.add_coupling("S","out1","T1","in");
    N.add_coupling("S","out2","T2","in");

    root = rootcoordinator("root",0,tend,N,0);
    root.sim();

    fprintf("ready\n")

    out = simout;
end