function [out] = testBatch(showPlot)
	if nargin == 0
      showPlot = false;
    end

    global simout
    global epsilon
    global DEBUGLEVEL
    global mu
   
    
  	tend = 40;


    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    mdebug = 0;
    nG = 100;
    tG = 1;
    tS = 15;
    rOut = 100;
    N1 = coordinator("N1");

    Generator = devs(am_generator("Generator", tG, 1, nG, [0,1], mdebug));
    Bat = devs(am_batch("Batch", 10, [0, 1], 0));
    Terminator = devs(am_terminator("Terminator",[0,1], mdebug));
    GenOut = devs(am_toworkspace("GenOut", "genOut", 0, "vector",[0,rOut],0));
    Batch_n = devs(am_toworkspace("batch_n", "batch_n", 0, "vector",[0,1],0));
    
    N1.add_model(Generator);   
    N1.add_model(Bat);
    N1.add_model(Terminator);
    N1.add_model(GenOut);
    N1.add_model(Batch_n);

    N1.add_coupling("Generator","out","Batch","in");
    N1.add_coupling("Batch","out","Terminator","in");    
    N1.add_coupling("Generator","out","GenOut","in");
    N1.add_coupling("Batch","n","batch_n","in");
   
    root = rootcoordinator("root",0,tend,N1,0,0);
    root.sim();

    if showPlot
        figure('Position',[1 1 550 350])
        subplot(2,1,1)
        stem(simout.genOut.t,simout.genOut.y); 
        grid("on");
        xlim([0 tend]);
        ylim([0, tend])
        ylabel("out");
        xlabel("t");
        title("Generator");
    
        subplot(2,1,2)
        stairs(simout.batch_n.t,simout.batch_n.y);
        grid("on");
        xlim([0 tend]);
        ylim([0, max(simout.batch_n.y)+1])
        ylabel("nq");
        xlabel("t");
        title("Batch");
        

    end

    out = simout;
end
