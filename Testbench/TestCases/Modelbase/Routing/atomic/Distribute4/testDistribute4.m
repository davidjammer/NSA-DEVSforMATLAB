function [out] = testDistribute4()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    
	tend = 25;
    
    
    nG = 100;
    tG = 1;
    tVec = [1.5 2.5 4.5 6.5 8.5 10.5];
    yVec = [2, 3, 2, 1, 4, 1];
    tend = 15;
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Generator1 = devs(am_generator("Generator1", tG, 1, nG, [0, 1], mdebug));
    Vectorgen = devs(am_vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
    Distribute4 = devs(am_distribute4("Distribute4", 1, [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, 1], mdebug));
    Terminator2 = devs(am_terminator("Terminator2", [0, 1], mdebug));
    Terminator3 = devs(am_terminator("Terminator3", [0, 1], mdebug));
    Terminator4 = devs(am_terminator("Terminator4", [0, 1], mdebug));
    Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", [0, rOut], 0));
    VGenout = devs(am_toworkspace("VGenout", "vgenOut", 0, "vector", [0, rOut], 0));
    Distout1 = devs(am_toworkspace("Distout1", "dist1Out", 0, "vector", [0, rOut], 0));
    Distout2 = devs(am_toworkspace("Distout2", "dist2Out", 0, "vector", [0, rOut], 0));
    Distout3 = devs(am_toworkspace("Distout3", "dist3Out", 0, "vector", [0, rOut], 0));
    Distout4 = devs(am_toworkspace("Distout4", "dist4Out", 0, "vector", [0, rOut], 0));

    N1.add_model(Generator1);
    N1.add_model(Vectorgen);
    N1.add_model(Distribute4);
    N1.add_model(Terminator1);
    N1.add_model(Terminator2);
    N1.add_model(Terminator3);
    N1.add_model(Terminator4);
    N1.add_model(Genout);
    N1.add_model(VGenout);
    N1.add_model(Distout1);
    N1.add_model(Distout2);
    N1.add_model(Distout3);
    N1.add_model(Distout4);

    N1.add_coupling("Generator1","out","Distribute4","in");
    N1.add_coupling("Vectorgen","out","Distribute4","port");
    N1.add_coupling("Distribute4","out1","Terminator1","in");
    N1.add_coupling("Distribute4","out2","Terminator2","in");
    N1.add_coupling("Distribute4","out3","Terminator3","in");
    N1.add_coupling("Distribute4","out4","Terminator4","in");
    N1.add_coupling("Generator1","out","Genout","in");
    N1.add_coupling("Vectorgen","out","VGenout","in");
    N1.add_coupling("Distribute4","out1","Distout1","in");
    N1.add_coupling("Distribute4","out2","Distout2","in");
    N1.add_coupling("Distribute4","out3","Distout3","in");
    N1.add_coupling("Distribute4","out4","Distout4","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();
    out = simout;

    if 0
        figure("name", "testDistribute4", "NumberTitle", "off", ...
	     "Position",[1 1 550 575]);
        subplot(4,2,1)
        stem(simout.genOut.t,simout.genOut.y);
        grid("on");
        xlim([0, tend])
        ylabel("out");
        title("Generator");
    
        subplot(4,2,3)
        stairs(simout.vgenOut.t,simout.vgenOut.y);
        hold("on");plot(simout.vgenOut.t,simout.vgenOut.y, "*");hold("off");
        grid("on");
        xlim([0, tend])
        ylim([0.8, 4.2])
        ylabel("out");
        title("Distributor port");
    
        subplot(4,2,2)
        stem(simout.dist1Out.t,simout.dist1Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out1");
        title("Distributor");
    
        subplot(4,2,4)
        stem(simout.dist2Out.t,simout.dist2Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out2");
        title("Distributor");
    
        subplot(4,2,6)
        stem(simout.dist3Out.t,simout.dist3Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out3");
        title("Distributor");

        subplot(4,2,8)
        stem(simout.dist4Out.t,simout.dist4Out.y);
        grid("on");
        xlim([0, tend])
        ylim([0, 15])
        ylabel("out4");
        title("Distributor");
    end
    
end
