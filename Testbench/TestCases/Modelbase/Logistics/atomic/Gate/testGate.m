function [out] = testGate()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tG = 0.9;
    n0 = 2;
    nG = 20;
    tEnable = [3.0, 6.0, 12, 14, 100];
    tEnd = 19;
    debug = false;               % model debug level
    tau = [0,1];
    tauOut = [0, 3.0];
    
    N1 = coordinator('N1');
    
    Generator = devs(am_generator("Generator", tG, n0, nG, tau, debug));
    Bingenerator = devs(am_bingenerator("Bingenerator", "1", tEnable, tau, debug));
    Terminator = devs(am_terminator("Terminator", tau, debug));
    Gate = devs(am_gate("gate", [0, 1], debug));
    Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", tauOut, 0));
    Gateout = devs(am_toworkspace("gateout", "gateOut", 0, "vector", tauOut, 0));
    Bingenout = devs(am_toworkspace("Bingenout", "bingenOut", 0, "vector", tauOut, 0));
    
    N1.add_model(Generator);
    N1.add_model(Bingenerator);
    N1.add_model(Terminator);
    N1.add_model(Gate);
    N1.add_model(Genout);
    N1.add_model(Gateout);
    N1.add_model(Bingenout);
    
    N1.add_coupling("Bingenerator","out","gate","open");
    N1.add_coupling("Generator","out","gate","in");
    N1.add_coupling("gate","out","Terminator","in");
    N1.add_coupling("Bingenerator","out","Bingenout","in");
    N1.add_coupling("Generator","out","Genout","in");
    N1.add_coupling("gate","out","gateout","in");

    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;
    
    if 0
        figure("name", "testGate", "NumberTitle", "off")
        subplot(3,1,1)
		plot_ieee1164(simout.bingenOut.t, simout.bingenOut.y);
        xlim([0 tEnd]);
        xlabel("t");
        ylabel("open");
        
        subplot(3,1,2)
        stem(simout.genOut.t,simout.genOut.y); grid on;
        xlim([0 tEnd]);
        ylim([0 21]);
        xlabel("t");
        ylabel("gen out");

        subplot(3,1,3)
        stem(simout.gateOut.t,simout.gateOut.y); grid on;
        xlim([0 tEnd]);
        ylim([0 21]);
        xlabel("t");
        ylabel("gate out");
    end
    
end