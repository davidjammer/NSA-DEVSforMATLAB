function testShiftregisterCM()
% external coupled
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [1, 2, 3, 4, 7, 9, 100];   % in
tVec2 = [0.5, 1.0];                 % clk
tEnd = 13;
mdebug = false;
rOut = 5;

N1 = coordinator("N1");
N2 = shiftregisterCM("N2", [0,1], mdebug);

Bingenerator1 = devs(bingenerator("Bingenerator1", 0, tVec1, [0,1], mdebug));
Bingenerator2 = devs(bingenerator("Bingenerator2", 1, tVec2, [0,1], mdebug));
Binout1 = devs(toworkspace("Binout1", "bin1Out", 0, "vector", [0,rOut], 0));
Binout2 = devs(toworkspace("Binout2", "bin2Out", 0, "vector", [0,rOut], 0));
JKFFq1 = devs(toworkspace("JKFFq1", "q1Out", 0, "vector", [0,rOut], 0));
JKFFq2 = devs(toworkspace("JKFFq2", "q2Out", 0, "vector", [0,rOut], 0));
JKFFq3 = devs(toworkspace("JKFFq3", "q3Out", 0, "vector", [0,rOut], 0));
JKFFq4 = devs(toworkspace("JKFFq4", "q4Out", 0, "vector", [0,rOut], 0));

N1.add_model(Bingenerator1);
N1.add_model(Bingenerator2);
N1.add_model(N2);
N1.add_model(Binout1);
N1.add_model(Binout2);
N1.add_model(JKFFq1);
N1.add_model(JKFFq2);
N1.add_model(JKFFq3);
N1.add_model(JKFFq4);

N1.add_coupling("Bingenerator1","out","N2","in");
N1.add_coupling("Bingenerator2","out","N2","clk");
N1.add_coupling("Bingenerator1","out","Binout1","in");
N1.add_coupling("Bingenerator2","out","Binout2","in");
N1.add_coupling("N2","out1","JKFFq1","in");
N1.add_coupling("N2","out2","JKFFq2","in");
N1.add_coupling("N2","out3","JKFFq3","in");
N1.add_coupling("N2","out4","JKFFq4","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name","testShiftregister","NumberTitle","off", ...
       "Position",[1 1 550 575]);
subplot(6,1,1)
stairs(simout.bin1Out.t,simout.bin1Out.y);
title("In");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,2)
stairs(simout.bin2Out.t,simout.bin2Out.y);
title("CLK");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,3)
stairs(simout.q1Out.t,simout.q1Out.y);
title("Out 1");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,4)
stairs(simout.q2Out.t,simout.q2Out.y);
title("Out 2");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,5)
stairs(simout.q3Out.t,simout.q3Out.y);
title("Out 3");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,6)
stairs(simout.q4Out.t,simout.q4Out.y);
title("Out 4");
xlim([0, tEnd])
ylim([-0.1, 1.1])
