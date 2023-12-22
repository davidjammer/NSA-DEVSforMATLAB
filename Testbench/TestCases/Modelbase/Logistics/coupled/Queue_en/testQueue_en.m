function [out] = testQueue_en()
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    if nargin == 0
      testcase = 1;
    end
    
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    tS = 1.5;
    tG = 3.0;
    tEnd = 200;
    tEnable = [20.0, 70.0, 110, 120];
    mdebug = false;               % model debug level
    rOut = 3.0;
    
    N1 = coordinator("N1");
    
    Generator = devs(am_generator("Generator", tG, 1, 50, [0, 1], mdebug));
    Buffer = cm_queue_en("Buffer", [0, 1], mdebug);
    Server = devs(am_server("Server", tS, [0, 1], mdebug));
    Terminator = devs(am_terminator("Terminator", [0, 1], mdebug));
    Bingenerator = devs(am_bingenerator("Bingenerator", "1", tEnable, [0, 1], mdebug));
    BufferNQ = devs(am_toworkspace("BufferNQ", "bufferNQ", 0, "vector", [0, rOut], mdebug));
    GenOut = devs(am_toworkspace("GenOut", "genOut", 0, "vector", [0, rOut], mdebug));
    SrvOut = devs(am_toworkspace("SrvOut", "srvOut", 0, "vector", [0, rOut], mdebug));
    SrvNOut = devs(am_toworkspace("SrvNOut", "srvnOut", 0, "vector", [0, rOut], mdebug));
    Bingenout = devs(am_toworkspace("Bingenout", "bingenOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Generator);
    N1.add_model(Buffer);
    N1.add_model(Server);
    N1.add_model(Terminator);
    N1.add_model(GenOut);
    N1.add_model(Bingenerator);
    N1.add_model(SrvOut);
    N1.add_model(SrvNOut);
    N1.add_model(BufferNQ);
    N1.add_model(Bingenout);
    
    N1.add_coupling("Generator","out","Buffer","in");
    N1.add_coupling("Bingenerator","out","Buffer","enable");
    N1.add_coupling("Bingenerator","out","Bingenout","in");
    N1.add_coupling("Buffer","out","Server","in");
    N1.add_coupling("Server","working","Buffer","bl");
    N1.add_coupling("Server","out","Terminator","in");
    N1.add_coupling("Generator","out","GenOut","in");
    N1.add_coupling("Server","out","SrvOut","in");
    N1.add_coupling("Server","n","SrvNOut","in");
    N1.add_coupling("Buffer","nq","BufferNQ","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if 0
        % plot results
        figure("name", "testQueue_en", "NumberTitle", "off")
        subplot(5,1,1)
        stem(simout.genOut.t,simout.genOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Generator");
        
        subplot(5,1,2)
		plot_ieee1164(simout.bingenOut.t, simout.bingenOut.y);
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("enable");

        subplot(5,1,3)
        stairs(simout.bufferNQ.t,simout.bufferNQ.y); grid on;
        xlim([0 tEnd]);
        ylim([0 20]);
        xlabel("simulation time");
        ylabel("NQ");

        subplot(5,1,4)
        stairs(simout.srvnOut.t,simout.srvnOut.y); grid on;
        hold("on");plot(simout.srvnOut.t,simout.srvnOut.y, "*");hold("off");
        xlim([0 tEnd]);
        ylim([-0.1, 1.1])
        xlabel("simulation time");
        ylabel("n");
        title("Server");
        
        subplot(5,1,5)
        stem(simout.srvOut.t,simout.srvOut.y); grid on;
        xlim([0 tEnd]);
        xlabel("simulation time");
        ylabel("out");
        title("Server");
    end
end