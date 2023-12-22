function [out] = test_cm_queue_server()
 
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.001;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    
    tEnd = 100;
    mdebug = false;
    rOut = 1.0;
    
    N1 = coordinator("N1");
    
    Generator = devs(am_generator("Generator", 1, 1, 20, [0, 1], mdebug));
    Queueserver = cm_queue_server("QueueServer", 4.5, [0,1],  mdebug);
	Terminator = devs(am_terminator("Terminator", [0,1], mdebug));

    Genout = devs(am_toworkspace("Genout", "genout", 0, "vector", [0, rOut], mdebug));
    Nqout = devs(am_toworkspace("Nqout", "nq", 0, "vector", [0, rOut], mdebug));
	Nqsout = devs(am_toworkspace("Nqsout", "nqs", 0, "vector", [0, rOut], mdebug));
	Srvout = devs(am_toworkspace("Srvout", "srvout", 0, "vector", [0, rOut], mdebug));
	Nout = devs(am_toworkspace("Nout", "nout", 0, "vector", [0, rOut], mdebug));

    N1.add_model(Generator);
    N1.add_model(Queueserver);
    N1.add_model(Terminator);
    N1.add_model(Genout);
	N1.add_model(Nqout);
	N1.add_model(Nqsout);
	N1.add_model(Srvout);
	N1.add_model(Nout);

    N1.add_coupling("Generator","out","QueueServer","in"); 
    N1.add_coupling("QueueServer","out","Terminator","in");

    N1.add_coupling("Generator","out","Genout","in");
	N1.add_coupling("QueueServer","nq","Nqout","in");
	N1.add_coupling("QueueServer","nqs","Nqsout","in");
	N1.add_coupling("QueueServer","out","Srvout","in");
	N1.add_coupling("Terminator","n","Nout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if 0
        figure("name", "testQueueServer", "NumberTitle", "off", "Position", [1 1 450 500]);
        subplot(5,1,1)
        stem(out.genout.t,out.genout.y,'-*');
        title("Generator out");
        xlim([0,tEnd])
        
		subplot(5,1,2)
        stairs(out.nq.t,out.nq.y,'-*');
        title("nq");
        xlim([0,tEnd])

		subplot(5,1,3)
        stairs(out.nqs.t,out.nqs.y,'-*');
        title("nqs");
        xlim([0,tEnd])

		subplot(5,1,4)
        stairs(out.srvout.t,out.srvout.y,'-*');
        title("Server out");
        xlim([0,tEnd])

		subplot(5,1,5)
        stairs(out.nout.t,out.nout.y,'-*');
        title("N out");
        xlim([0,tEnd])
    end
end