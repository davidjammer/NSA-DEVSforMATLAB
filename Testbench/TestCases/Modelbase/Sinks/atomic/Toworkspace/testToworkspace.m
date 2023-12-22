function [out] = testToworkspace()
    global simout
    global simin
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.000;
    simout = [];
    DEBUGLEVEL = 0;
    epsilon = 1e-6;
    
    
    tend = 10;
    simin.in.t = [0,  1, 2, 3, 4, 5];
    simin.in.y = [1,1.2,7,9,10,100];
    
    
    N1 = coordinator('N1');
    FromWorkspace = devs(am_fromworkspace("gen", "in", [0,1], 0));
    ToWorkspace1 = devs(am_toworkspace('sink1','out1',0, "vector", [0, 100], 0));
    ToWorkspace2 = devs(am_toworkspace('sink2','out2',0, "single", [0, 100], 0));
    
    N1.add_model(FromWorkspace);
    N1.add_model(ToWorkspace1);
    N1.add_model(ToWorkspace2);
    
    N1.add_coupling('gen','out','sink1','in');
    N1.add_coupling('gen','out','sink2','in');
    
    root = rootcoordinator('root',0,tend,N1,0,0);
    
    root.sim();
    out = simout;
    
    if 0
        figure()
        stem(simout.out1.t,simout.out1.y); grid on;
        xlim([0 tend]);
        xlabel('simulation time');
        ylabel('out');
        title('fromworkspace');

		disp(simout.out2.t);
		disp(simout.out2.y);
    end


end
