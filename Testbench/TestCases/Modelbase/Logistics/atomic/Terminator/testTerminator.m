function [out] = testTerminator()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tG = 1;
    n0 = 1;
    nG = 20;
    tEnd = 100;
    debug = false;               % model debug level
    tau = [0,1];
    tauOut = [0, 3.0];
    
    N1 = coordinator('N1');
    
    Generator = devs(am_generator("Generator", tG, n0, nG, tau, debug));
    Terminator = devs(am_terminator("Terminator", tau, debug));
    Termout = devs(am_toworkspace("Termout", "termOut", 0, "vector", tauOut, 0));
    
    N1.add_model(Generator);
    N1.add_model(Terminator);
    N1.add_model(Termout);
    
    N1.add_coupling("Generator","out","Terminator","in");
    N1.add_coupling("Terminator","n","Termout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;
    
    if 0
        figure("name", "testTerminator", "NumberTitle", "off")
        
        subplot(1,1,1)
        stem(simout.termOut.t,simout.termOut.y); grid on;
        xlim([0 100]);
        ylim([0 30]);
        xlabel("t");
        ylabel("term out");
    end
    
end