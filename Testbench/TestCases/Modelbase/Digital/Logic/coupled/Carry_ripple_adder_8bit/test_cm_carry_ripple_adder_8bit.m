function [out] = test_cm_carry_ripple_adder_8bit(showPlot)
	if nargin == 0
      showPlot = false;
    end

    global simout
    global epsilon
    global DEBUGLEVEL
    global mu
    mu = 0.000;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec2 = [1, 2, 3, 6];
    yVec2 = [200, 240, 255, 100];
    tVec1 = [1, 4, 5, 6];
    yVec1 = [10, 11, 12, 13];
    
    tVec3 = [1, 4, 5, 6];
    yVec3 = ["0", "1", "0", "0"];
    tEnd = 15;
    mdebug = false;
    rOut = 100.0;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    Vectorgen2 = devs(am_vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
    Vectorgen3 = devs(am_vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
    
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
    
    AdderSout = devs(am_toworkspace("AdderSout", "addersOut", 0, "vector", [0, rOut], mdebug));
    AdderCout = devs(am_toworkspace("AdderCout", "addercOut", 0, "vector", [0, rOut], mdebug));
    
    Dectobin1 = devs(am_dec_to_bin8("dectobin1",[0, 1],mdebug));
    Dectobin2 = devs(am_dec_to_bin8("dectobin2",[0, 1],mdebug));
    Adder = cm_carry_ripple_adder_8bit("Adder",[0, 1],mdebug);
    Bintodec = devs(am_bin8_to_dec("bintodec",[0, 1],mdebug));
    
    
    N1.add_model(Vectorgen1);
    N1.add_model(Vectorgen2);
    N1.add_model(Vectorgen3);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Gen3out);
    N1.add_model(Dectobin1);
    N1.add_model(Dectobin2);
    N1.add_model(Adder);
    N1.add_model(Bintodec);
    N1.add_model(AdderSout);
    N1.add_model(AdderCout);
    
    
    N1.add_coupling("Vectorgen1","out","dectobin1","in1");
    N1.add_coupling("Vectorgen2","out","dectobin2","in1");
    
    N1.add_coupling("dectobin1","out1","Adder","a1");
    N1.add_coupling("dectobin1","out2","Adder","a2");
    N1.add_coupling("dectobin1","out3","Adder","a3");
    N1.add_coupling("dectobin1","out4","Adder","a4");
    N1.add_coupling("dectobin1","out5","Adder","a5");
    N1.add_coupling("dectobin1","out6","Adder","a6");
    N1.add_coupling("dectobin1","out7","Adder","a7");
    N1.add_coupling("dectobin1","out8","Adder","a8");
    
    N1.add_coupling("dectobin2","out1","Adder","b1");
    N1.add_coupling("dectobin2","out2","Adder","b2");
    N1.add_coupling("dectobin2","out3","Adder","b3");
    N1.add_coupling("dectobin2","out4","Adder","b4");
    N1.add_coupling("dectobin2","out5","Adder","b5");
    N1.add_coupling("dectobin2","out6","Adder","b6");
    N1.add_coupling("dectobin2","out7","Adder","b7");
    N1.add_coupling("dectobin2","out8","Adder","b8");
    
    N1.add_coupling("Vectorgen3","out","Adder","c");
    
    N1.add_coupling("Adder","s1","bintodec","in1");
    N1.add_coupling("Adder","s2","bintodec","in2");
    N1.add_coupling("Adder","s3","bintodec","in3");
    N1.add_coupling("Adder","s4","bintodec","in4");
    N1.add_coupling("Adder","s5","bintodec","in5");
    N1.add_coupling("Adder","s6","bintodec","in6");
    N1.add_coupling("Adder","s7","bintodec","in7");
    N1.add_coupling("Adder","s8","bintodec","in8");
    
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Vectorgen2","out","Gen2out","in");
    N1.add_coupling("Vectorgen3","out","Gen3out","in");
    N1.add_coupling("bintodec","out","AdderSout","in");
    N1.add_coupling("Adder","cout","AdderCout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();

    out = simout;


    if showPlot
        figure("name", "testcarryrippleadder", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
        title("a");
        xlim([0,16])
        ylim([0,20])
        
        subplot(5,1,2)
        stairs(simout.gen2Out.t,simout.gen2Out.y,'-*');
        title("b");
        xlim([0,16])
        ylim([0,270])
        
        subplot(5,1,3)
        plot_ieee1164(simout.gen3Out.t, simout.gen3Out.y);
        title("c");
        xlim([0,16])
        
        subplot(5,1,4)
        stairs(simout.addersOut.t,simout.addersOut.y,'-*');
        title("Adder s");
        xlim([0,16])
        ylim([0,270])
        
        subplot(5,1,5)
        plot_ieee1164(simout.addercOut.t, simout.addercOut.y);
        title("Adder c");
        xlim([0,16])
    end
end