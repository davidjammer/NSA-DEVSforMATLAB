function [out] = testComparator(tend)
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    if(nargin ~= 1)
	   tend = 17;
    end
    
    tVec = [1, 3, 7, 8, 9];
    yVec = [2, -3, 2, -2, -1];
    tEnd = 17;
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen = devs(vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
    Comparator = devs(comparator("Comparator", [0, 1], mdebug));
    Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
    Genout = devs(toworkspace("Genout", "genOut", 0, [0, rOut]));
    Compout = devs(toworkspace("Compout", "compOut", 0, [0, rOut]));

    N1.add_model(Vectorgen);
    N1.add_model(Comparator);
    N1.add_model(Terminator1);
    N1.add_model(Genout);
    N1.add_model(Compout);

    N1.add_coupling("Vectorgen","out","Comparator","in");
    N1.add_coupling("Comparator","out","Terminator1","in");
    N1.add_coupling("Vectorgen","out","Genout","in");
    N1.add_coupling("Comparator","out","Compout","in");

    root = rootcoordinator("root",0,tEnd,N1,0);
    root.sim();

    figure("name", "testComparator", "NumberTitle", "off", ...
	 "Position", [1 1 450 500]);
    subplot(3,1,1)
    stairs(simout.genOut.t,simout.genOut.y);
    hold("on");plot(simout.genOut.t,simout.genOut.y, "*");hold("off");
    grid("on");
    xlim([0, tEnd])
    ylim([-3.2, 2.2])
    xlabel("simulation time");
    ylabel("out");
    title("VectorGen");

    subplot(3,1,2)
    stairs(simout.compOut.t,simout.compOut.y);
    hold("on");plot(simout.compOut.t,simout.compOut.y, "*");hold("off");
    grid("on");
    xlim([0, tEnd])
    ylim([-0.2, 1.2])
    xlabel("simulation time");
    ylabel("out");
    title("Comparator");

    subplot(3,1,3)
    stairs(simout.tOut.t,simout.tOut.y);
    grid("on");
    xlim([0, tEnd])
    ylim([-0.2, 9.2])
    xlabel("simulation time");
    ylabel("ni");
    title("Terminator");
   
    out = simout;
end
