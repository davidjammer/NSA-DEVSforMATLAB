function [out] = test_fromworkspace(tend,in)

    global simout
    global simin
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.000;
    simout = [];
    DEBUGLEVEL = 0;
    epsilon = 1e-6;

    
    
    if(nargin ~= 2)
	   tend = 10;
	   simin.in.t = [0,  1, 2, 3, 4, 5];
	   simin.in.y = [10,11,12,13,14,15];
    else
	   simin.in = in;
    end
    
    N1 = coordinator('N1');
    FromWorkspace = devs(fromworkspace("gen", [0,1], "in", 0));
    ToWorkspace = devs(toworkspace('sink','out',0,[0, 100]));

    N1.add_model(FromWorkspace);
    N1.add_model(ToWorkspace);

    N1.add_coupling('gen','out','sink','in');

    root = rootcoordinator('root',0,tend,N1,0);
    tic;
    root.sim();
    ta=toc

    figure(2)
    stem(simout.out.t,simout.out.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out');
    title('pipe');
   
    out = simout;
end
