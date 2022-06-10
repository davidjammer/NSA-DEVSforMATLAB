function [out] = compswitch(tend, testcase)
    % different testcases:
    %  1     all tauDef, rOut late   (default)
    %  2     all tauDef, rOut early
    %  3     like 2, but with mi != 0
    %  4     tauSwitch late, rOut early
    global simout
    global epsilon
    global DEBUGLEVEL
    global mi

    if(nargin ~= 2)
	   if ~exist('tend','var')
		tend = 17.5;
	   end
	   if ~exist('testcase','var')
		 testcase = 1; 
	   end
    end

    switch testcase
	 case 1
	   mi = 0;
	   rOut = 3.0;
	   rSwitch = 1.0;
	 case 2
	   mi = 0;
	   rOut = 0.05;
	   rSwitch = 1.0;
	 case 3
	   mi = 0.01;
	   rOut = 0.05;
	   rSwitch = 1.0;
	 case 4
	   mi = 0;
	   rOut = 0.05;
	   rSwitch = 2.0;
	 otherwise
	   mi = 0;
	   rOut = 3.0;
	   rSwitch = 1.0;
    end

    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;

    tVec = [1, 3, 7, 8, 9];
    yVec = [2, -3, -2, 1, -1];
 
    mdebug = false;

    N1 = coordinator("N1");

    Vectorgen = devs(vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
    Comparator = devs(comparator("Comparator", [0, 1], mdebug));
    Outputswitch = devs(outputswitch("Outputswitch", 1, [0, rSwitch], mdebug));
    Terminator1 = devs(terminator("Terminator1", [0, 1], mdebug));
    Terminator2 = devs(terminator("Terminator2", [0, 1], mdebug));
    VGenout = devs(toworkspace("VGenout", "vgenOut", 0, [0, rOut]));
    Compout = devs(toworkspace("Compout", "compOut", 0, [0, rOut]));
    Switchout1 = devs(toworkspace("Switchout1", "sw1Out", 0, [0, rOut]));
    Switchout2 = devs(toworkspace("Switchout2", "sw2Out", 0, [0, rOut]));

    N1.add_model(Vectorgen);
    N1.add_model(Comparator);
    N1.add_model(Outputswitch);
    N1.add_model(Terminator1);
    N1.add_model(Terminator2);
    N1.add_model(VGenout);
    N1.add_model(Compout);
    N1.add_model(Switchout1);
    N1.add_model(Switchout2);

    N1.add_coupling("Vectorgen","out","Comparator","in");
    N1.add_coupling("Vectorgen","out","Outputswitch","in");
    N1.add_coupling("Comparator","out","Outputswitch","sw");
    N1.add_coupling("Outputswitch","out1","Terminator1","in");
    N1.add_coupling("Outputswitch","out2","Terminator2","in");
    N1.add_coupling("Vectorgen","out","VGenout","in");
    N1.add_coupling("Comparator","out","Compout","in");
    N1.add_coupling("Outputswitch","out1","Switchout1","in");
    N1.add_coupling("Outputswitch","out2","Switchout2","in");

    root = rootcoordinator("root",0,tend,N1,0);
    root.sim();

    figure("name", "compswitchA", "NumberTitle", "off", ...
	 "Position", [1 1 450 600]);
    subplot(4,1,1)
    stem(simout.vgenOut.t,simout.vgenOut.y);
    grid("on");
    xlim([0, tend])
    ylim([-3.2, 2.2])
    ylabel("out");
    title("VectorGen");

    subplot(4,1,2)
    stairs(simout.compOut.t,simout.compOut.y);
    hold("on");plot(simout.compOut.t,simout.compOut.y, "*");hold("off");
    grid("on");
    xlim([0, tend])
    ylim([-0.1, 1.1])
    ylabel("out");
    title("Comparator");

    subplot(4,1,3)
    stem(simout.sw1Out.t,simout.sw1Out.y);
    grid("on");
    xlim([0, tend])
    ylim([-3.2, 2.2])
    ylabel("out1");
    title("Switch");

    subplot(4,1,4)
    stem(simout.sw2Out.t,simout.sw2Out.y);
    grid("on");
    xlim([0, tend])
    ylim([-3.2, 2.2])
    ylabel("out2");
    title("Switch");

    out = simout;
end