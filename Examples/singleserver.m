function [out] = singleserver(tend, testcase)
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

    % default values
    mdebug = false;
    mi = 0.0;
    rD = 1.0;      % queue in queuingFree state
    rQ = 1.0;      % queue, input delay
    rS = 1.0;      % server, input delay
    rOut = 3.0;

    switch testcase
	 case 1   % default values 
	   % -> E3 lost
	 case 2   % correct behaviour
	   rD = 1.5;     % must be > 1.0
	 case 3   % correct behaviour with spikes
	   rD = 1.5;
	   rOut = 0.5;
	 case 4   %  case 3 with debugging
	   mi = 0.01;
	   rD = 1.5;
	   rOut = 1e-4;
	 case 5   % [NSA-DEVS1, fig.6]
	   rOut = 0.5;
	   rQ = 1.0;
	   rS = 2.0;
	   tend = 10;
	 otherwise
	   % default values
    end

    nG = 100;
    tG = 1;
    tS = 1.5;
    disp(mi);
    get_mi()
    N1 = coordinator("N1");

    Generator = devs(generator1("Generator", tG, 1, nG, [0,1], mdebug));
    Queue = devs(queue("Queue", [0,rQ], mdebug, [0,rD]));
    Server = devs(server("Server", tS, [0,rS], mdebug));
    Terminator = devs(terminator("Terminator",[0,1], mdebug));
    GenOut = devs(toworkspace("GenOut", "genOut", 0,[0,rOut]));
    QueOut = devs(toworkspace("QueOut", "queOut", 0,[0,rOut]));
    QueNOut = devs(toworkspace("QueNOut", "quenOut", 0,[0,rOut]));
    SrvOut = devs(toworkspace("SrvOut", "srvOut", 0,[0,rOut]));

    N1.add_model(Generator);
    N1.add_model(Queue);
    N1.add_model(Server);
    N1.add_model(Terminator);
    N1.add_model(GenOut);
    N1.add_model(QueOut);
    N1.add_model(QueNOut);
    N1.add_model(SrvOut);

    N1.add_coupling("Generator","out","Queue","in");
    N1.add_coupling("Queue","out","Server","in");
    N1.add_coupling("Server","out","Terminator","in");
    N1.add_coupling("Server","working","Queue","bl");
    N1.add_coupling("Generator","out","GenOut","in");
    N1.add_coupling("Queue","out","QueOut","in");
    N1.add_coupling("Queue","nq","QueNOut","in");
    N1.add_coupling("Server","out","SrvOut","in");

    root = rootcoordinator("root",0,tend,N1,0);
    root.sim();

    % plot results
    figure('Position',[1 1 550 350])
    subplot(2,2,1)
    stem(simout.genOut.t,simout.genOut.y); 
    grid("on");
    xlim([0 tend]);
    ylim([0, tend])
    ylabel("out");
    xlabel("t");
    title("Generator");

    subplot(2,2,2)
    stem(simout.queOut.t,simout.queOut.y);
    grid("on");
    xlim([0 tend]);
    ylim([0, 20])
    ylabel("out");
    xlabel("t");
    title("Queue");

    subplot(2,2,3)
    stairs(simout.quenOut.t,simout.quenOut.y);
    %hold("on");plot(simout.quenOut.t,simout.quenOut.y, "*");hold("off");
    grid("on");
    xlim([0 tend]);
    ylim([0, max(simout.quenOut.y)+1])
    ylabel("nq");
    xlabel("t");
    title("Queue");

    subplot(2,2,4)
    stem(simout.srvOut.t,simout.srvOut.y);
    grid("on");
    xlim([0 tend]);
    ylim([0, 20])
    ylabel("out");
    xlabel("t");
    title("Server");
    
    out = simout;
end
