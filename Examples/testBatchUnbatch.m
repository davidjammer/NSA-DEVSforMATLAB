function [out] = testBatchUnbatch(tend)
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
   
    if(nargin ~= 1)
  		tend = 40;
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

    Generator = devs(generator("Generator", tG, 1, nG, [0,1], mdebug));
    Bat = devs(batch("Batch", 10, [0, 1], 0));
    Unbatch = devs(unbatch("Unbatch", [0, 1], [0, 100], 0));
    Queue = devs(queue("Queue", [0,3], [0,3], mdebug));
    Server = devs(server("Server", tS, [0,1], mdebug));
    Terminator = devs(terminator("Terminator",[0,1], mdebug));
    GenOut = devs(toworkspace("GenOut", "genOut", 0, "vector",[0,rOut],0));
    QueOut = devs(toworkspace("QueOut", "queOut", 0, "vector",[0,1],0));
    QueNOut = devs(toworkspace("QueNOut", "quenOut", 0, "vector",[0,rOut],0));
    SrvOut = devs(toworkspace("SrvOut", "srvOut", 0, "vector",[0,rOut],0));
    Batch_n = devs(toworkspace("batch_n", "batch_n", 0, "vector",[0,1],0));
    Unbatch_out = devs(toworkspace("unbatch_out", "unbatch_out", 0, "vector",[0,0.5],0));
    
    N1.add_model(Generator);
    N1.add_model(Queue);
    N1.add_model(Server);
    N1.add_model(Bat);
    N1.add_model(Unbatch);
    N1.add_model(Terminator);
    N1.add_model(GenOut);
    N1.add_model(QueOut);
    N1.add_model(QueNOut);
    N1.add_model(SrvOut);
    N1.add_model(Batch_n);
    N1.add_model(Unbatch_out);

    N1.add_coupling("Generator","out","Queue","in");
    N1.add_coupling("Queue","out","Batch","in");
    N1.add_coupling("Batch","out","Server","in");
    N1.add_coupling("Server","out","Unbatch","in");
    N1.add_coupling("Server","working","Queue","bl");
    
    N1.add_coupling("Generator","out","GenOut","in");
    N1.add_coupling("Queue","out","QueOut","in");
    N1.add_coupling("Queue","nq","QueNOut","in");
    N1.add_coupling("Server","out","SrvOut","in");
    N1.add_coupling("Batch","n","batch_n","in");
    N1.add_coupling("Unbatch","out","unbatch_out","in");

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
    stem(simout.unbatch_out.t,simout.unbatch_out.y);
    grid("on");
    xlim([0 tend]);
    ylim([0, max(simout.unbatch_out.y)+1])
    xlabel("t");
    title("Unbatch");
    
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
    
    out = simout;
end
