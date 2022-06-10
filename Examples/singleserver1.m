function [out] = singleserver1(tend, simulatorDebug, testcase)
    % singleserver without output for sequence diagram
    % default values -> E3 lost
    % features component and simulator Debug 
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi
    
    if(nargin ~= 3)
	   if ~exist('tend','var')
		tend = 4.5;
	   end
	   if ~exist('testcase','var')
		 testcase = 2; 
	   end
	   if ~exist('simulatorDebug','var')
		 simulatorDebug = false; 
	   end
    end
    


    if simulatorDebug
	 mdebug = false;
	 DEBUGLEVEL = 1;
	 mi = 0.0;
    else    % component debug
	 mdebug = true;
	 DEBUGLEVEL = 0;
	 mi = 0.01;
    end

    % default values
    rD = 1.0;      % queue in queuingFree state
    rQ = 1.0;      % queue, input delay
    rS = 1.0;      % server, input delay
    

    switch testcase
	 case 1   % default values 
	   % -> E3 lost
	 case 2   % correct behaviour
	   rD = 2;     % must be > 1.0
    end

    simout = [];
    epsilon = 1e-6;

    nG = 100;
    tG = 1;
    tS = 1.5;
    disp(mi);
    get_mi();
    N1 = coordinator("N1");

    Generator = devs(generator1("Generator", tG, 1, nG, [0,1], mdebug));
    Queue = devs(queue("Queue", [0,rQ], mdebug, [0,rD]));
    Server = devs(server("Server", tS, [0,rS], mdebug));
    Terminator = devs(terminator("Terminator",[0,1], false));

    N1.add_model(Generator);
    N1.add_model(Queue);
    N1.add_model(Server);
    N1.add_model(Terminator);

    N1.add_coupling("Generator","out","Queue","in");
    N1.add_coupling("Queue","out","Server","in");
    N1.add_coupling("Server","out","Terminator","in");
    N1.add_coupling("Server","working","Queue","bl");

    root = rootcoordinator("root",0,tend,N1,0);
    root.sim();

    out = simout;
end