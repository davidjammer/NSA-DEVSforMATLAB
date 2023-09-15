function [out] = model4(tend)

    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    mi = 0.000;
    simout = [];
    DEBUGLEVEL = 0;
    epsilon = 1e-6;

    if(nargin ~= 1)
	   tend = 10;
    end
    
    N1 = coordinator('N1');
    N2 = coordinator('N2');
    N3 = coordinator('N3');

    Generator11 = devs(generator('Generator11',1.0,0,Inf,[0, 1],0));
    Pipe21 = devs(pipe('Pipe21',[0, 2]));
    Pipe31 = devs(pipe('Pipe31',[0, 2]));
    Pipe22 = devs(pipe('Pipe22',[0, 2]));
    Terminator11 = devs(terminator('Terminator11',[0, 3], 0));
    ToWorkspace21 = devs(toworkspace('logpipe21','pipe21',0,"vector",[0, 100],0));
    ToWorkspace31 = devs(toworkspace('logpipe31','pipe31',0,"vector",[0, 100],0));
    ToWorkspace22 = devs(toworkspace('logpipe22','pipe22',0,"vector",[0, 100],0));

    N1.add_model(Generator11);
    N1.add_model(Terminator11);
    N1.add_model(N2);

    N2.add_model(Pipe21);
    N2.add_model(Pipe22);
    N2.add_model(ToWorkspace21);
    N2.add_model(ToWorkspace22);
    N2.add_model(N3);

    N3.add_model(Pipe31);
    N3.add_model(ToWorkspace31);

    N1.add_coupling('Generator11','out','N2','in');
    N1.add_coupling('N2','out','Terminator11','in');

    N2.add_coupling('N2','in','Pipe21','in');
    N2.add_coupling('Pipe21','out_d','N3','in');
    N2.add_coupling('Pipe21','out_p','logpipe21','in');

    N2.add_coupling('N3','out','Pipe22','in');
    N2.add_coupling('Pipe22','out_d','N2','out');
    N2.add_coupling('Pipe22','out_p','logpipe22','in');

    N3.add_coupling('N3','in','Pipe31','in');
    N3.add_coupling('Pipe31','out_d','N3','out');
    N3.add_coupling('Pipe31','out_p','logpipe31','in');

    root = rootcoordinator('root',0,tend,N1,0);
    tic;
    root.sim();
    ta=toc

    fprintf("\npipe21:\n")
    fprintf("%2d  %2d\n", [simout.pipe21.t; simout.pipe21.y])
    fprintf("\npipe31:\n")
    fprintf("%2d  %2d\n", [simout.pipe31.t; simout.pipe31.y])
    fprintf("\npipe22:\n")
    fprintf("%2d  %2d\n", [simout.pipe22.t; simout.pipe22.y])

    figure(2)
    subplot(3,1,1)
    stem(simout.pipe21.t,simout.pipe21.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe21');

    subplot(3,1,2)
    stem(simout.pipe31.t,simout.pipe31.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe31');

    subplot(3,1,3)
    stem(simout.pipe22.t,simout.pipe22.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe22');

    out = simout;
end
