function [out] = testUnbatch()

    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.000;
    simout = [];
    DEBUGLEVEL = 0;
    epsilon = 1e-6;
    

    tend = 40;
    
    
    N1 = coordinator('N1');
    
    Gen = devs(am_generator("Gen", 1, 0, Inf, [0,1], 0));
    Bat = devs(am_batch("batch", 10, [0,1], 0));
    Unbatch = devs(am_unbatch("unbatch", [0,1], [0,2], 0)); 
    Fifo1 = devs(am_queue("fifo1", [0,1], [0,1], 0)); 
    c0 = devs(am_const("c0", "1", [0,1], [0,1], 0));
    ToWorkspace = devs(am_toworkspace('logunbatch', 'out', 0, "vector", [0,0.5], 0));
    
    N1.add_model(Gen);
    N1.add_model(Bat);
    N1.add_model(Unbatch);
    N1.add_model(Fifo1);
    N1.add_model(c0);
    N1.add_model(ToWorkspace);
    
    N1.add_coupling('Gen','out','batch','in');
    N1.add_coupling('batch','out','unbatch','in');
    N1.add_coupling('unbatch','out','fifo1','in');
    N1.add_coupling('c0','out','fifo1','bl');
    N1.add_coupling('unbatch','out','logunbatch','in');
    
    root = rootcoordinator('root',0,tend,N1,0,0);
    root.sim();
    out = simout;
    
    if 0
        figure
        stem(simout.out.t,simout.out.y); grid on;
        xlim([0 tend]);
        xlabel('simulation time');
        title('unbatch out');
    end
    
end
