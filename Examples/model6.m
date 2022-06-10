function [out] = model6(tend)

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

    %% -----------------------------------------------------------
    N1 = coordinator('N1');
    Pipe1 = devs(pipe('Pipe1',[0, 2]));
    Pipe2 = devs(pipe('Pipe2',[0, 2]));

    N1.add_model(Pipe1);
    N1.add_model(Pipe2);

    N1.add_coupling('N1','in','Pipe1','in');
    N1.add_coupling('Pipe1','out_p','N1','out_p1');
    N1.add_coupling('Pipe1','out_d','Pipe2','in');
    N1.add_coupling('Pipe2','out_p','N1','out_p2');
    N1.add_coupling('Pipe2','out_d','N1','out');
    %% ----------------------------------------------------------
    N0 = coordinator('N0');

    Generator = devs(generator('Generator',1.0,[0, 1]));
    Terminator = devs(terminator('Terminator',[0, 3], 0));
    ToWorkspace1 = devs(toworkspace('logpipe1','pipe1',0,[0, 100]));
    ToWorkspace2 = devs(toworkspace('logpipe2','pipe2',0,[0, 100]));
    ToWorkspace3 = devs(toworkspace('logpipe3','pipe3',0,[0, 100]));
    ToWorkspace4 = devs(toworkspace('logpipe4','pipe4',0,[0, 100]));
    ToWorkspace5 = devs(toworkspace('logpipe5','pipe5',0,[0, 100]));
    ToWorkspace6 = devs(toworkspace('logpipe6','pipe6',0,[0, 100]));
    ToWorkspace7 = devs(toworkspace('logpipe7','pipe7',0,[0, 100]));
    ToWorkspace8 = devs(toworkspace('logpipe8','pipe8',0,[0, 100]));

    N2 = N1.copy('N2');
    N3 = N1.copy('N3');
    N4 = N1.copy('N4');

    N0.add_model(Generator);
    N0.add_model(Terminator);
    N0.add_model(ToWorkspace1);
    N0.add_model(ToWorkspace2);
    N0.add_model(ToWorkspace3);
    N0.add_model(ToWorkspace4);
    N0.add_model(ToWorkspace5);
    N0.add_model(ToWorkspace6);
    N0.add_model(ToWorkspace7);
    N0.add_model(ToWorkspace8);
    N0.add_model(N1);
    N0.add_model(N2);
    N0.add_model(N3);
    N0.add_model(N4);

    N0.add_coupling('Generator','out','N1','in');
    N0.add_coupling('N1','out','N2','in');
    N0.add_coupling('N2','out','N3','in');
    N0.add_coupling('N3','out','N4','in');
    N0.add_coupling('N4','out','Terminator','in');
    N0.add_coupling('N1','out_p1','logpipe1','in');
    N0.add_coupling('N1','out_p2','logpipe2','in');
    N0.add_coupling('N2','out_p1','logpipe3','in');
    N0.add_coupling('N2','out_p2','logpipe4','in');
    N0.add_coupling('N3','out_p1','logpipe5','in');
    N0.add_coupling('N3','out_p2','logpipe6','in');
    N0.add_coupling('N4','out_p1','logpipe7','in');
    N0.add_coupling('N4','out_p2','logpipe8','in');

    root = rootcoordinator('root',0,tend,N0,0);
    tic;
    root.sim();
    ta=toc

    figure
    subplot(8,1,1)
    stem(simout.pipe1.t,simout.pipe1.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe1');

    subplot(8,1,2)
    stem(simout.pipe2.t,simout.pipe2.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe2');

    subplot(8,1,3)
    stem(simout.pipe3.t,simout.pipe3.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe3');

    subplot(8,1,4)
    stem(simout.pipe4.t,simout.pipe4.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe4');

    subplot(8,1,5)
    stem(simout.pipe5.t,simout.pipe5.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe5');

    subplot(8,1,6)
    stem(simout.pipe6.t,simout.pipe6.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe6');

    subplot(8,1,7)
    stem(simout.pipe7.t,simout.pipe7.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe7');

    subplot(8,1,8)
    stem(simout.pipe8.t,simout.pipe8.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe8');

    out = simout;
end