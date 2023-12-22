function [out]=testSaturation()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec = [1,    3, 7,  8,    9];
    yVec = [0.2, -3, 2, -0.9,  0];
    g = 2;
    tEnd = 17;
    mdebug = false;
    rOut = 3.0;
    
    N1 = coordinator("N1");
    
    Vectorgen = devs(am_vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
    Saturation = devs(am_saturation("Saturation", -1, 1, [0, 1], mdebug));
    Terminator1 = devs(am_terminator("Terminator", [0, rOut], mdebug));
    Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", [0, rOut], mdebug));
    Saturationout = devs(am_toworkspace("Saturationout", "saturationOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen);
    N1.add_model(Saturation);
    N1.add_model(Terminator1);
    N1.add_model(Genout);
    N1.add_model(Saturationout);
    
    N1.add_coupling("Vectorgen","out","Saturation","in");
    N1.add_coupling("Saturation","out","Terminator1","in");
    N1.add_coupling("Vectorgen","out","Genout","in");
    N1.add_coupling("Saturation","out","Saturationout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    
    out = simout;

    if 0
        figure("name", "testSaturation", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(2,1,1)
        stem(simout.genOut.t,simout.genOut.y);
        title("Generator");
        xlim([0,tEnd])
        ylim([-5,5])
    
        subplot(2,1,2)
        stem(simout.saturationOut.t,simout.saturationOut.y);
        title("Saturation");
        xlim([0,tEnd])
        ylim([-5,5])
    end

end