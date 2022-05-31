function testJkflipflopCM()
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [3, 4, 5, 6, 9, 11];        % J
tVec2 = [0.5, 1.0];                 % CLK
tVec3 = [1, 2, 7, 8, 10, 12, 100];  % K
tEnd = 14;
mdebug = false;
rJK = 1;
rOut = 10.0;

N1 = coordinator("N1");

Bingenerator1 = devs(bingenerator("Bingenerator1", 0, tVec1, [0,1], mdebug));
Bingenerator2 = devs(bingenerator("Bingenerator2", 1, tVec2, [0,1], mdebug));
Bingenerator3 = devs(bingenerator("Bingenerator3", 0, tVec3, [0,1], mdebug));
Jkff = jkflipflopCM("JKFF", rJK, mdebug);
Terminator1 = devs(terminator("Terminator1", [0,1], mdebug));
Terminator2 = devs(terminator("Terminator2", [0,1], mdebug));
Binout1 = devs(toworkspace("Binout1", "binOut1", 0, [0,rOut]));
Binout2 = devs(toworkspace("Binout2", "binOut2", 0, [0,rOut]));
Binout3 = devs(toworkspace("Binout3", "binOut3", 0, [0,rOut]));
Jkffout1 = devs(toworkspace("JKFFq", "qOut", 0, [0,rOut]));
Jkffout2 = devs(toworkspace("JKFFqb", "qbOut", 0, [0,rOut]));

N1.add_model(Bingenerator1);
N1.add_model(Bingenerator2);
N1.add_model(Bingenerator3);
N1.add_model(Jkff);
N1.add_model(Terminator1);
N1.add_model(Terminator2);
N1.add_model(Binout1);
N1.add_model(Binout2);
N1.add_model(Binout3);
N1.add_model(Jkffout1);
N1.add_model(Jkffout2);

N1.add_coupling("Bingenerator1","out","JKFF","j");
N1.add_coupling("Bingenerator2","out","JKFF","clk");
N1.add_coupling("Bingenerator3","out","JKFF","k");
N1.add_coupling("JKFF","q","Terminator1","in");
N1.add_coupling("JKFF","qb","Terminator2","in");
N1.add_coupling("Bingenerator1","out","Binout1","in");
N1.add_coupling("Bingenerator2","out","Binout2","in");
N1.add_coupling("Bingenerator3","out","Binout3","in");
N1.add_coupling("JKFF","q","JKFFq","in");
N1.add_coupling("JKFF","qb","JKFFqb","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name","testJkflipflop", "Position",[1 1 500 550]);
subplot(5,1,1)
stairs(simout.binOut1.t,simout.binOut1.y);
title("J");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(5,1,2)
stairs(simout.binOut3.t,simout.binOut3.y);
title("K");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(5,1,3)
stairs(simout.binOut2.t,simout.binOut2.y);
title("CLK");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(5,1,4)
stairs(simout.qOut.t,simout.qOut.y);
title("Q");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(5,1,5)
stairs(simout.qbOut.t,simout.qbOut.y);
title("Qb");
xlim([0, tEnd])
ylim([-0.1, 1.1])
