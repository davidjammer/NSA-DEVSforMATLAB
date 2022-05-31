function testRSFF1()
clear all;
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [0, 1, 4, 4.5, 8, 8.5 10];
yVec1 = [0, 0, 1, 0  , 1, 0,  0];
tVec2 = [0, 1, 6, 6.5, 10];
yVec2 = [0, 0, 1, 0  , 0];

tVec3 = [0, 3.5, 7, 10];
yVec3 = [0, 1,   0, 0];
tEnd = 50;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Vectorgen2 = devs(vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
Vectorgen3 = devs(vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
RS = rs1flipflopCM("RS", [0, 1], mdebug);
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
Gen3out = devs(toworkspace("Gen3out", "gen3Out", 0, [0, rOut]));
RSoutq = devs(toworkspace("RSoutq", "rsoutq", 0, [0, rOut]));
RSoutqn = devs(toworkspace("RSoutqn", "rsoutqn", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Vectorgen2);
N1.add_model(Vectorgen3);
N1.add_model(RS);
N1.add_model(Terminator1);
N1.add_model(Gen1out);
N1.add_model(Gen2out);
N1.add_model(Gen3out);
N1.add_model(RSoutq);
N1.add_model(RSoutqn);

N1.add_coupling("Vectorgen1","out","RS","S");
N1.add_coupling("Vectorgen2","out","RS","R");
N1.add_coupling("Vectorgen3","out","RS","C");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("Vectorgen2","out","Gen2out","in");
N1.add_coupling("Vectorgen3","out","Gen3out","in");
N1.add_coupling("RS","Q","RSoutq","in");
N1.add_coupling("RS","Qn","RSoutqn","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testRSFlipFlop", "NumberTitle", "off", "Position", [1 1 450 500]);
subplot(5,1,1)
stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
title("set");
xlim([0,tEnd])
ylim([0,1.3])

subplot(5,1,2)
stairs(simout.gen2Out.t,simout.gen2Out.y,'-*');
title("reset");
xlim([0,tEnd])
ylim([0,1.3])

subplot(5,1,3)
stairs(simout.gen3Out.t,simout.gen3Out.y,'-*');
title("clock");
xlim([0,tEnd])
ylim([0,1.3])

subplot(5,1,4)
stairs(simout.rsoutq.t,simout.rsoutq.y,'-*');
title("q");
xlim([0,tEnd])
ylim([0,1.3])

subplot(5,1,5)
stairs(simout.rsoutqn.t,simout.rsoutqn.y,'-*');
title("qn");
xlim([0,tEnd])
ylim([0,1.3])
