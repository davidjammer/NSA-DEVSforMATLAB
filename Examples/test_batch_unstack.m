function [out] = test_batch_unstack(tend)
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
   
    if(nargin ~= 2)
	   if ~exist('tend','var')
		tend = 20;
	   end
	   if ~exist('testcase','var')
		 testcase = 1; 
	   end
    end

    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    mdebug = 0;
    nG = 100;
    tG = 1;
    tS = 15;
    rOut = 100;
    N1 = coordinator("N1");

    Generator = devs(generator1("Generator", tG, 1, nG, [0,1], mdebug));
    Bat = devs(batch("Batch", [0, 1], 0, 10));
    Unstack = devs(unstack("Unstack",[0, 100], 0));
    Queue = devs(queue("Queue", [0,3], mdebug, [0,3]));
    Server = devs(server("Server", tS, [0,1], mdebug));
    Terminator = devs(terminator("Terminator",[0,1], mdebug));
    GenOut = devs(toworkspace("GenOut", "genOut", 0,[0,rOut]));
    QueOut = devs(toworkspace("QueOut", "queOut", 0,[0,1]));
    QueNOut = devs(toworkspace("QueNOut", "quenOut", 0,[0,rOut]));
    SrvOut = devs(toworkspace("SrvOut", "srvOut", 0,[0,rOut]));
    Batch_n = devs(toworkspace("batch_n", "batch_n", 0,[0,1]));
    Unstack_out = devs(toworkspace("unstack_out", "unstack_out", 0,[0,1]));
    
    N1.add_model(Generator);
    N1.add_model(Queue);
    N1.add_model(Server);
    N1.add_model(Bat);
    N1.add_model(Unstack);
    N1.add_model(Terminator);
    N1.add_model(GenOut);
    N1.add_model(QueOut);
    N1.add_model(QueNOut);
    N1.add_model(SrvOut);
    N1.add_model(Batch_n);
    N1.add_model(Unstack_out);

%     N1.add_coupling("Generator","out","Batch","in");
%     N1.add_coupling("Batch","out","Unstack","in");
%     N1.add_coupling("Unstack","out","Queue","in");
%     N1.add_coupling("Queue","out","Server","in");
%     N1.add_coupling("Server","working","Queue","bl");
    N1.add_coupling("Generator","out","Queue","in");
    N1.add_coupling("Queue","out","Batch","in");
    N1.add_coupling("Batch","out","Server","in");
    N1.add_coupling("Server","out","Unstack","in");
    N1.add_coupling("Server","working","Queue","bl");
    
    N1.add_coupling("Generator","out","GenOut","in");
    N1.add_coupling("Queue","out","QueOut","in");
    N1.add_coupling("Queue","nq","QueNOut","in");
    N1.add_coupling("Server","out","SrvOut","in");
    N1.add_coupling("Batch","n","batch_n","in");
    N1.add_coupling("Unstack","out","unstack_out","in");

    root = rootcoordinator("root",0,tend,N1,0);
    root.sim();

    % plot results
    figure('Position',[1 1 550 350])
    subplot(2,3,1)
    stem(simout.genOut.t,simout.genOut.y); 
    grid("on");
    xlim([0 tend]);
    ylim([0, tend])
    ylabel("out");
    xlabel("t");
    title("Generator");

    subplot(2,3,2)
    stairs(simout.batch_n.t,simout.batch_n.y);
    grid("on");
    xlim([0 tend]);
    ylim([0, max(simout.batch_n.y)+1])
    ylabel("nq");
    xlabel("t");
    title("Batch");
    
    subplot(2,3,3)
    stem(simout.unstack_out.t,simout.unstack_out.y);
    grid("on");
    xlim([0 tend]);
    ylim([0, max(simout.unstack_out.y)+1])
    xlabel("t");
    title("Unstack");
    
    subplot(2,3,4)
    stem(simout.queOut.t,simout.queOut.y);
    grid("on");
    xlim([0 tend]);
    ylim([0, 20])
    ylabel("out");
    xlabel("t");
    title("Queue");

    subplot(2,3,5)
    stairs(simout.quenOut.t,simout.quenOut.y);
    grid("on");
    xlim([0 tend]);
    ylim([0, max(simout.quenOut.y)+1])
    ylabel("nq");
    xlabel("t");
    title("Queue");

%     subplot(2,3,6)
%     stem(simout.srvOut.t,simout.srvOut.y);
%     grid("on");
%     xlim([0 tend]);
%     ylim([0, 20])
%     ylabel("out");
%     xlabel("t");
%     title("Server");
    
    out = simout;
end
