function [out] = testQueue()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec = [0.1 4.5 7.5 9.0 11.0 100];
    yVec = ["1" "0" "1" "0" "1" "1"];
    tG = 1.0;
    n0 = 1.0;
    nG = 100;
    tEnd = 12;
    mdebug = false;               % model debug level
    rOut = 1.0;
    
    N1 = coordinator("N1");
    
    Generator = devs(am_generator("Generator", tG, n0, nG, [0, 1], mdebug));
    Vectorgen = devs(am_vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
    Queue = devs(am_queue("Queue", [0, 2], [0, 1], mdebug));
    Terminator = devs(am_terminator("Terminator", [0, 1], mdebug));
    GenOut = devs(am_toworkspace("GenOut", "genOut", 0, "vector", [0, rOut], mdebug));
    VgenOut = devs(am_toworkspace("VgenOut", "vgenOut", 0, "vector", [0, rOut], mdebug));
    queOut = devs(am_toworkspace("QueOut", "queOut", 0, "vector", [0, rOut], mdebug));
    queNOut = devs(am_toworkspace("QueNOut", "queNOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Generator);
    N1.add_model(Vectorgen);
    N1.add_model(Queue);
    N1.add_model(Terminator);
    N1.add_model(GenOut);
    N1.add_model(VgenOut);
    N1.add_model(queOut);
    N1.add_model(queNOut);
    
    N1.add_coupling("Generator","out","Queue","in");
    N1.add_coupling("Vectorgen","out","Queue","bl");
    N1.add_coupling("Queue","out","Terminator","in");
    N1.add_coupling("Generator","out","GenOut","in");
    N1.add_coupling("Vectorgen","out","VgenOut","in");
    N1.add_coupling("Queue","out","QueOut","in");
    N1.add_coupling("Queue","nq","QueNOut","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if 0
        % plot results
        figure("name", "testQueue", "NumberTitle", "off")
        subplot(2,2,1)
        stem(simout.genOut.t,simout.genOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Generator");
        
        subplot(2,2,2)
        plot_ieee1164(simout.vgenOut.t, simout.vgenOut.y);
		xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("in");
        title("Blocking");
        
        subplot(2,2,3)
        stem(simout.queOut.t,simout.queOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Queue");
        
        subplot(2,2,4)
        stairs(simout.queNOut.t,simout.queNOut.y); grid on;
        hold("on");plot(simout.queNOut.t,simout.queNOut.y, "*");hold("off");
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("nq");
        title("Queue");
    end
end