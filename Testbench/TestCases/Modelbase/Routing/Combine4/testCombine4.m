function [out]= testCombine4(showPlot)
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

    tend = 15;
 
    
    nG = 100;
    tG1 = 1;
    tG2 = 2;
    tG3 = 3;
    tG4 = 3.5;
    mdebug = false;
    rOut = 1.0;

    N1 = coordinator("N1");

    Generator1 = devs(am_generator("Generator1", tG1, 1, nG, [0, 1], mdebug));
    Generator2 = devs(am_generator("Generator2", tG2, 21, nG, [0, 1], mdebug));
    Generator3 = devs(am_generator("Generator3", tG3, 41, nG, [0, 1], mdebug));
    Generator4 = devs(am_generator("Generator4", tG4, 12, nG, [0, 1], mdebug));
    Combine4 = devs(am_combine4("Combine4", [0, 10], [0, 10], mdebug));
    Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
    Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
    Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
    Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
    Gen4out = devs(am_toworkspace("Gen4out", "gen4Out", 0, "vector", [0, rOut], mdebug));
    Combout = devs(am_toworkspace("Combout", "combOut", 0, "vector", [0, rOut], mdebug));

    N1.add_model(Generator1);
    N1.add_model(Generator2);
    N1.add_model(Generator3);
    N1.add_model(Generator4);
    N1.add_model(Combine4);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Gen3out);
    N1.add_model(Gen4out);
    N1.add_model(Combout);

    N1.add_coupling("Generator1","out","Combine4","in1");
    N1.add_coupling("Generator2","out","Combine4","in2");
    N1.add_coupling("Generator3","out","Combine4","in3");
    N1.add_coupling("Generator4","out","Combine4","in4");
    N1.add_coupling("Combine4","out","Terminator1","in");
    N1.add_coupling("Generator1","out","Gen1out","in");
    N1.add_coupling("Generator2","out","Gen2out","in");
    N1.add_coupling("Generator3","out","Gen3out","in");
    N1.add_coupling("Generator4","out","Gen4out","in");
    N1.add_coupling("Combine4","out","Combout","in");

    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();

    if showPlot
        figure("name", "testCombine4", "NumberTitle", "off", ...
	     "Position", [1 1 450 500]);
        subplot(5,1,1)
        stem(simout.gen1Out.t,simout.gen1Out.y);
        title("Generator 1");
        xlim([0,16])
    
        subplot(5,1,2)
        stem(simout.gen2Out.t,simout.gen2Out.y);
        title("Generator 2");
        xlim([0,16])
    
        subplot(5,1,3)
        stem(simout.gen3Out.t,simout.gen3Out.y);
        title("Generator 3");
        xlim([0,16])
	    
        subplot(5,1,4)
        stem(simout.gen4Out.t,simout.gen4Out.y);
        title("Generator 4");
        xlim([0,16])

        subplot(5,1,5)
        stem(simout.combOut.t,simout.combOut.y);
        title("Combine4");
        xlim([0,16])
    end

    out = simout;
end





