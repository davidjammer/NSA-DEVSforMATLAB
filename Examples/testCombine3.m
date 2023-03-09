function [out]= testCombine3(tend)

    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.000;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    if(nargin ~= 1)
	   tend = 15;
    end
    
    nG = 100;
    tG1 = 1;
    tG2 = 2;
    tG3 = 3;
    mdebug = false;
    rOut = 1.0;

    N1 = coordinator("N1");

    Generator1 = devs(generator1("Generator1", tG1, 1, nG, [0, 1], mdebug));
    Generator2 = devs(generator1("Generator2", tG2, 21, nG, [0, 1], mdebug));
    Generator3 = devs(generator1("Generator3", tG3, 41, nG, [0, 1], mdebug));
    Combine3 = devs(combine3("Combine3", [0, 10], [0, 10], true));
    Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
    Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
    Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
    Gen3out = devs(toworkspace("Gen3out", "gen3Out", 0, [0, rOut]));
    Combout = devs(toworkspace("Combout", "combOut", 0, [0, rOut]));

    N1.add_model(Generator1);
    N1.add_model(Generator2);
    N1.add_model(Generator3);
    N1.add_model(Combine3);
    N1.add_model(Terminator1);
    N1.add_model(Gen1out);
    N1.add_model(Gen2out);
    N1.add_model(Gen3out);
    N1.add_model(Combout);

    N1.add_coupling("Generator1","out","Combine3","in1");
    N1.add_coupling("Generator2","out","Combine3","in2");
    N1.add_coupling("Generator3","out","Combine3","in3");
    N1.add_coupling("Combine3","out","Terminator1","in");
    N1.add_coupling("Generator1","out","Gen1out","in");
    N1.add_coupling("Generator2","out","Gen2out","in");
    N1.add_coupling("Generator3","out","Gen3out","in");
    N1.add_coupling("Combine3","out","Combout","in");

    root = rootcoordinator("root",0,tend,N1,0);
    root.sim();

    figure("name", "testCombine3", "NumberTitle", "off", ...
	 "Position", [1 1 450 500]);
    subplot(3,2,1)
    stem(simout.gen1Out.t,simout.gen1Out.y);
    title("Generator 1");
    xlim([0,16])

    subplot(3,2,2)
    stem(simout.gen2Out.t,simout.gen2Out.y);
    title("Generator 2");
    xlim([0,16])

    subplot(3,2,3)
    stem(simout.gen3Out.t,simout.gen3Out.y);
    title("Generator 3");
    xlim([0,16])
	
    subplot(3,2,5)
    stem(simout.combOut.t,simout.combOut.y);
    title("Combine3");
    xlim([0,16])

    out = simout;
end





