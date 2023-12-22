function [out] = test_am_bin8_to_dec()
    
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.001;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec1 = [0:1:255];
    yVec1 = [0:1:255];
    
    
    
    tEnd = 256;
    mdebug = false;
    rOut = 1.0;
    
    N1 = coordinator("N1");
    
    Vectorgen1 = devs(am_vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
    
    Dectobin8 = devs(am_dec_to_bin8("dectobin8", [0, 1], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Bin8todecout = devs(am_toworkspace("Bin8todecout", "bin8todecOut", 0, "vector", [0, rOut], mdebug));
    Bin8todec = devs(am_bin8_to_dec("Bintodec", [0, 1], mdebug));
    Dectobin8out_0 = devs(am_toworkspace("Dectobin8out_0", "dectobin8Out0", 0, "vector", [0, rOut], mdebug));
    Dectobin8out_1 = devs(am_toworkspace("Dectobin8out_1", "dectobin8Out1", 0, "vector", [0, rOut], mdebug));
    Dectobin8out_2 = devs(am_toworkspace("Dectobin8out_2", "dectobin8Out2", 0, "vector", [0, rOut], mdebug));
    Dectobin8out_3 = devs(am_toworkspace("Dectobin8out_3", "dectobin8Out3", 0, "vector", [0, rOut], mdebug));
    Dectobin8out_4 = devs(am_toworkspace("Dectobin8out_4", "dectobin8Out4", 0, "vector", [0, rOut], mdebug));
    Dectobin8out_5 = devs(am_toworkspace("Dectobin8out_5", "dectobin8Out5", 0, "vector", [0, rOut], mdebug));
    Dectobin8out_6 = devs(am_toworkspace("Dectobin8out_6", "dectobin8Out6", 0, "vector", [0, rOut], mdebug));
    Dectobin8out_7 = devs(am_toworkspace("Dectobin8out_7", "dectobin8Out7", 0, "vector", [0, rOut], mdebug));
    
    
    N1.add_model(Vectorgen1);
    N1.add_model(Dectobin8);
    N1.add_model(Bin8todec);
    N1.add_model(Bin8todecout);
    N1.add_model(Gen1out);
    N1.add_model(Dectobin8out_0);
    N1.add_model(Dectobin8out_1);
    N1.add_model(Dectobin8out_2);
    N1.add_model(Dectobin8out_3);
    N1.add_model(Dectobin8out_4);
    N1.add_model(Dectobin8out_5);
    N1.add_model(Dectobin8out_6);
    N1.add_model(Dectobin8out_7);
    
    N1.add_coupling("Vectorgen1","out","dectobin8","in1");
    
    N1.add_coupling("Vectorgen1","out","Gen1out","in");
    N1.add_coupling("Bintodec","out","Bin8todecout","in");
    
    N1.add_coupling("dectobin8","out1","Bintodec","in1");
    N1.add_coupling("dectobin8","out2","Bintodec","in2");
    N1.add_coupling("dectobin8","out3","Bintodec","in3");
    N1.add_coupling("dectobin8","out4","Bintodec","in4");
    N1.add_coupling("dectobin8","out5","Bintodec","in5");
    N1.add_coupling("dectobin8","out6","Bintodec","in6");
    N1.add_coupling("dectobin8","out7","Bintodec","in7");
    N1.add_coupling("dectobin8","out8","Bintodec","in8");
    
    N1.add_coupling("dectobin8","out1","Dectobin8out_0","in");
    N1.add_coupling("dectobin8","out2","Dectobin8out_1","in");
    N1.add_coupling("dectobin8","out3","Dectobin8out_2","in");
    N1.add_coupling("dectobin8","out4","Dectobin8out_3","in");
    N1.add_coupling("dectobin8","out5","Dectobin8out_4","in");
    N1.add_coupling("dectobin8","out6","Dectobin8out_5","in");
    N1.add_coupling("dectobin8","out7","Dectobin8out_6","in");
    N1.add_coupling("dectobin8","out8","Dectobin8out_7","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if 0
        figure("name", "testNand2", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(10,1,1)
        stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
        title("Generator 1");
        xlim([0,tEnd])
        ylim([0,260])
        
        subplot(10,1,2)
        plot_ieee1164(simout.dectobin8Out0.t, simout.dectobin8Out0.y);
        title("bin0");
        xlim([0,tEnd])
        
        subplot(10,1,3)
        plot_ieee1164(simout.dectobin8Out1.t, simout.dectobin8Out1.y);
        title("bin1");
        xlim([0,tEnd])
        
        subplot(10,1,4)
        plot_ieee1164(simout.dectobin8Out2.t, simout.dectobin8Out2.y);
        title("bin2");
        xlim([0,tEnd])
        
        subplot(10,1,5)
        plot_ieee1164(simout.dectobin8Out3.t, simout.dectobin8Out3.y);
        title("bin3");
        xlim([0,tEnd])
        
        subplot(10,1,6)
        plot_ieee1164(simout.dectobin8Out4.t, simout.dectobin8Out4.y);
        title("bin4");
        xlim([0,tEnd])
        
        subplot(10,1,7)
        plot_ieee1164(simout.dectobin8Out5.t, simout.dectobin8Out5.y);
        title("bin5");
        xlim([0,tEnd])
        
        subplot(10,1,8)
        plot_ieee1164(simout.dectobin8Out6.t, simout.dectobin8Out6.y);
        title("bin6");
        xlim([0,tEnd])
        
        subplot(10,1,9)
        plot_ieee1164(simout.dectobin8Out7.t, simout.dectobin8Out7.y);
        title("bin7");
        xlim([0,tEnd])
        
        subplot(10,1,10)
        stairs(simout.bin8todecOut.t,simout.bin8todecOut.y,'-*');
        title("Out");
        xlim([0,tEnd])
        ylim([0,260])

    end
end