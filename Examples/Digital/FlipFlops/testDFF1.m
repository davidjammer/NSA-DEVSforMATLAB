function testDFF1()
clear all;
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [0.9, 3.9, 4.6, 7.5, 8, 10];
yVec1 = [0, 1,   0,   1,   0, 0];

tVec2 = [1, 4, 4.5, 5.5, 6, 10];
yVec2 = [0, 1, 0,   1,   0, 0];
tEnd = 50;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Vectorgen2 = devs(vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
D = DflipflopFCM("DFF", [0, 1], mdebug);
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
Doutq = devs(toworkspace("Doutq", "doutq", 0, [0, rOut]));
Doutqn = devs(toworkspace("Doutqn", "doutqn", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Vectorgen2);
N1.add_model(D);
N1.add_model(Terminator1);
N1.add_model(Gen1out);
N1.add_model(Gen2out);
N1.add_model(Doutq);
N1.add_model(Doutqn);

N1.add_coupling("Vectorgen1","out","DFF","D");
N1.add_coupling("Vectorgen2","out","DFF","C");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("Vectorgen2","out","Gen2out","in");
N1.add_coupling("DFF","Q","Doutq","in");
N1.add_coupling("DFF","Qn","Doutqn","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testDFlipFlop", "NumberTitle", "off", "Position", [1 1 450 500]);
subplot(4,1,1)
stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
title("data");
xlim([0,tEnd])
ylim([0,1.3])

subplot(4,1,2)
stairs(simout.gen2Out.t,simout.gen2Out.y,'-*');
title("clock");
xlim([0,tEnd])
ylim([0,1.3])

subplot(4,1,3)
stairs(simout.doutq.t,simout.doutq.y,'-*');
title("q");
xlim([0,tEnd])
ylim([0,1.3])

subplot(4,1,4)
stairs(simout.doutqn.t,simout.doutqn.y,'-*');
title("qn");
xlim([0,tEnd])
ylim([0,1.3])


