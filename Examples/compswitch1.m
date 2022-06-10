function [out] = compswitch1(tend)
    % mini version of compswitchA for  debugging
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.01;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    if(nargin ~= 1)
	   tend = 2.5;
    end
    
    tVec = [1 2];
    yVec = [1 -2];
    mdebug = true;
    rOut = 0.1;

    N = coordinator("N1");

    Vectorgen = devs(vectorgen("G", tVec, yVec, [0, 1], mdebug));
    Comparator = devs(comparator("C", [0, 1], mdebug));
    Outputswitch = devs(outputswitch("S", 1, [0, 1], mdebug));
    Terminator1 = devs(terminator("T1", [0, 1], mdebug));
    Terminator2 = devs(terminator("T2", [0, 1], mdebug));
    VGenout = devs(toworkspace("VGenout", "vgenOut", 0, [0, rOut]));
    Compout = devs(toworkspace("Compout", "compOut", 0, [0, rOut]));
    Switchout1 = devs(toworkspace("Switchout1", "sw1Out", 0, [0, rOut]));
    Switchout2 = devs(toworkspace("Switchout2", "sw2Out", 0, [0, rOut]));

    N.add_model(Vectorgen);
    N.add_model(Comparator);
    N.add_model(Outputswitch);
    N.add_model(Terminator1);
    N.add_model(Terminator2);
    N.add_model(VGenout);
    N.add_model(Compout);
    N.add_model(Switchout1);
    N.add_model(Switchout2);

    N.add_coupling("G","out","C","in");
    N.add_coupling("G","out","S","in");
    N.add_coupling("C","out","S","sw");
    N.add_coupling("S","out1","T1","in");
    N.add_coupling("S","out2","T2","in");
    N.add_coupling("G","out","VGenout","in");
    N.add_coupling("C","out","Compout","in");
    N.add_coupling("S","out1","Switchout1","in");
    N.add_coupling("S","out2","Switchout2","in");

    root = rootcoordinator("root",0,tend,N,0);
    root.sim();

    figure("name", "compswitch1", "NumberTitle", "off", ...
	 "Position", [1 1 450 600]);
    subplot(4,1,1)
    stem(simout.vgenOut.t,simout.vgenOut.y);
    grid("on");
    xlim([0, tend])
    ylim([-3.2, 2.2])
    ylabel("out");
    title("VectorGen");

    subplot(4,1,2)
    stairs(simout.compOut.t,simout.compOut.y);
    hold("on");plot(simout.compOut.t,simout.compOut.y, "*");hold("off");
    grid("on");
    xlim([0, tend])
    ylim([-0.1, 1.1])
    ylabel("out");
    title("Comparator");

    subplot(4,1,3)
    stem(simout.sw1Out.t,simout.sw1Out.y);
    grid("on");
    xlim([0, tend])
    ylim([-3.2, 2.2])
    ylabel("out1");
    title("Switch");

    subplot(4,1,4)
    stem(simout.sw2Out.t,simout.sw2Out.y);
    grid("on");
    xlim([0, tend])
    ylim([-3.2, 2.2])
    ylabel("out2");
    title("Switch");

    sTitle = sprintf("Demo with rOut = %4.2f, mi = %4.2f", rOut, mi);
    sgtitle(sTitle)
   
    out = simout;
end
