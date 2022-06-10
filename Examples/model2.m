function [out] = model2(tend)

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

    Generator = devs(generator('Generator',1.00,[0, 1]));
    Pipe = devs(pipe('Pipe',[0, 2]));
    Terminator = devs(terminator('Terminator',[0, 3], 0));
    ToWorkspace = devs(toworkspace('logpipe','pipe',0,[0, 100]));

    N1.add_model(N2);
    N1.add_model(Generator);
    N2.add_model(Pipe);
    N1.add_model(Terminator);
    N1.add_model(ToWorkspace);

    N1.add_coupling('Generator','out','N2','in0');

    N2.add_coupling('N2','in0','Pipe','in');
    N2.add_coupling('Pipe','out_d','N2','out0');
    N2.add_coupling('Pipe','out_p','N2','out1');

    N1.add_coupling('N2','out0','Terminator','in');
    N1.add_coupling('N2','out1','logpipe','in');

  

    root = rootcoordinator('root',0,tend,N1,0);
    tic;
    root.sim();
    ta=toc

    figure(2)
    stem(simout.pipe.t,simout.pipe.y); grid on;
    xlim([0 tend]);
    xlabel('simulation time');
    ylabel('out_p');
    title('pipe');
   
    out = simout;
end