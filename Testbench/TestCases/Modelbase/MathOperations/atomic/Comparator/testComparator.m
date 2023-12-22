function [out] = testComparator()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

   
	tend = 17;
    
    
    tVec1 = [0, 1,  3, 7,  8,  9];
    yVec1 = [0, 4, -3, 2, -2, -1];
    tVec2 = [0, 1,  3, 7,  8,  9];
    yVec2 = [0, 2,  8, 2, -2, -9];

    tEnd = 17;
    mdebug = false;
    rOut = 3.0;

    N1 = coordinator("N1");

    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Comparator1 = devs(am_comparator("Comparator1", ">", [0, 1], mdebug));
    Comparator2 = devs(am_comparator("Comparator2", "<", [0, 1], mdebug));
    Comparator3 = devs(am_comparator("Comparator3", ">=", [0, 1], mdebug));
    Comparator4 = devs(am_comparator("Comparator4", "<=", [0, 1], mdebug));
    Comparator5 = devs(am_comparator("Comparator5", "==", [0, 1], mdebug));
    Comparator6 = devs(am_comparator("Comparator6", "~=", [0, 1], mdebug));
    
    Genout1 = devs(am_toworkspace("Genout1", "genOut1", 0, "vector", [0, rOut],0));
    Genout2 = devs(am_toworkspace("Genout2", "genOut2", 0, "vector", [0, rOut],0));

    Compout1 = devs(am_toworkspace("Compout1", "compOut1", 0, "vector", [0, rOut],0));
    Compout2 = devs(am_toworkspace("Compout2", "compOut2", 0, "vector", [0, rOut],0));
    Compout3 = devs(am_toworkspace("Compout3", "compOut3", 0, "vector", [0, rOut],0));
    Compout4 = devs(am_toworkspace("Compout4", "compOut4", 0, "vector", [0, rOut],0));
    Compout5 = devs(am_toworkspace("Compout5", "compOut5", 0, "vector", [0, rOut],0));
    Compout6 = devs(am_toworkspace("Compout6", "compOut6", 0, "vector", [0, rOut],0));

    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Comparator1);
    N1.add_model(Comparator2);
    N1.add_model(Comparator3);
    N1.add_model(Comparator4);
    N1.add_model(Comparator5);
    N1.add_model(Comparator6);
    N1.add_model(Genout1);
    N1.add_model(Genout2);
    N1.add_model(Compout1);
    N1.add_model(Compout2);
    N1.add_model(Compout3);
    N1.add_model(Compout4);
    N1.add_model(Compout5);
    N1.add_model(Compout6);

    N1.add_coupling("Vectorgen1","out","Comparator1","in1");
    N1.add_coupling("Vectorgen2","out","Comparator1","in2");
    N1.add_coupling("Vectorgen1","out","Comparator2","in1");
    N1.add_coupling("Vectorgen2","out","Comparator2","in2");
    N1.add_coupling("Vectorgen1","out","Comparator3","in1");
    N1.add_coupling("Vectorgen2","out","Comparator3","in2");
    N1.add_coupling("Vectorgen1","out","Comparator4","in1");
    N1.add_coupling("Vectorgen2","out","Comparator4","in2");
    N1.add_coupling("Vectorgen1","out","Comparator5","in1");
    N1.add_coupling("Vectorgen2","out","Comparator5","in2");
    N1.add_coupling("Vectorgen1","out","Comparator6","in1");
    N1.add_coupling("Vectorgen2","out","Comparator6","in2");

    N1.add_coupling("Vectorgen1","out","Genout1","in");
    N1.add_coupling("Vectorgen2","out","Genout2","in");

    N1.add_coupling("Comparator1","out","Compout1","in");
    N1.add_coupling("Comparator2","out","Compout2","in");
    N1.add_coupling("Comparator3","out","Compout3","in");
    N1.add_coupling("Comparator4","out","Compout4","in");
    N1.add_coupling("Comparator5","out","Compout5","in");
    N1.add_coupling("Comparator6","out","Compout6","in");

    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();

    if 0
        figure("name", "testComparator", "NumberTitle", "off", ...
	     "Position", [1 1 450 500]);
        subplot(7,1,1)
        stem(simout.genOut1.t,simout.genOut1.y);
        hold on;
        stem(simout.genOut2.t,simout.genOut2.y);
        hold off;

        grid("on");
        xlim([0, tEnd])
        xlabel("simulation time");
        ylabel("out");
        title("VectorGen");
        legend("in1","in2");

        subplot(7,1,2)
		plot_ieee1164(simout.compOut1.t, simout.compOut1.y);
        grid("on");
        xlim([0, tEnd])
        xlabel("simulation time");
        ylabel("out");
        title("in1>in2");

        subplot(7,1,3)
		plot_ieee1164(simout.compOut2.t, simout.compOut2.y);
        grid("on");
        xlim([0, tEnd])
        xlabel("simulation time");
        ylabel("out");
        title("in1<in2");
   
        subplot(7,1,4)
		plot_ieee1164(simout.compOut3.t, simout.compOut3.y);
        grid("on");
        xlim([0, tEnd])
        xlabel("simulation time");
        ylabel("out");
        title("in1>=in2");

        subplot(7,1,5)
		plot_ieee1164(simout.compOut4.t, simout.compOut4.y);
        grid("on");
        xlim([0, tEnd])
        xlabel("simulation time");
        ylabel("out");
        title("in1<=in2");

        subplot(7,1,6)
		plot_ieee1164(simout.compOut5.t, simout.compOut5.y);
        grid("on");
        xlim([0, tEnd])
        xlabel("simulation time");
        ylabel("out");
        title("in1==in2");

        subplot(7,1,7)
		plot_ieee1164(simout.compOut6.t, simout.compOut6.y);
        grid("on");
        xlim([0, tEnd])
        xlabel("simulation time");
        ylabel("out");
        title("in1~=in2");

        fprintf("in1:\t%2d %2d %2d %2d %2d %2d %2d %2d %2d %2d\n", simout.genOut1.y);
        fprintf("in2:\t%2d %2d %2d %2d %2d %2d %2d %2d %2d %2d\n", simout.genOut2.y);
        fprintf("> :\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", simout.compOut1.y);
        fprintf("< :\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", simout.compOut2.y);
        fprintf(">=:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", simout.compOut3.y);
        fprintf("<=:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", simout.compOut4.y);
        fprintf("==:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", simout.compOut5.y);
        fprintf("~=:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", simout.compOut6.y);

        
    end
    out = simout;
end
