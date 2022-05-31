function testNand4()
clear all;
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
yVec1 = [0, 1, 0, 1, 0, 1, 0, 1, 0, 1,  0,  1,  0,  1,  0,  1,  0];
tVec2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
yVec2 = [0, 0, 1, 1, 0, 0, 1, 1, 0, 0,  1,  1,  0,  0,  1,  1,  0];
tVec3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
yVec3 = [0, 0, 0, 0, 1, 1, 1, 1, 0, 0,  0,  0,  1,  1,  1,  1,  0];
tVec4 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
yVec4 = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1,  1,  1,  1,  1,  1,  1,  0];
tEnd = 30;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Vectorgen2 = devs(vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
Vectorgen3 = devs(vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
Vectorgen4 = devs(vectorgen("Vectorgen4", tVec4, yVec4, [0, 1], mdebug));
Nand4 = nand4CM("Nand4", [0, 1], mdebug);
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
Gen3out = devs(toworkspace("Gen3out", "gen3Out", 0, [0, rOut]));
Gen4out = devs(toworkspace("Gen4out", "gen4Out", 0, [0, rOut]));
Nandout = devs(toworkspace("Nandout", "nandOut", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Vectorgen2);
N1.add_model(Vectorgen3);
N1.add_model(Vectorgen4);
N1.add_model(Nand4);
N1.add_model(Terminator1);
N1.add_model(Gen1out);
N1.add_model(Gen2out);
N1.add_model(Gen3out);
N1.add_model(Gen4out);
N1.add_model(Nandout);

N1.add_coupling("Vectorgen1","out","Nand4","in1");
N1.add_coupling("Vectorgen2","out","Nand4","in2");
N1.add_coupling("Vectorgen3","out","Nand4","in3");
N1.add_coupling("Vectorgen4","out","Nand4","in4");
N1.add_coupling("Nand4","out","Terminator1","in");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("Vectorgen2","out","Gen2out","in");
N1.add_coupling("Vectorgen3","out","Gen3out","in");
N1.add_coupling("Vectorgen4","out","Gen4out","in");
N1.add_coupling("Nand4","out","Nandout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testNand4", "NumberTitle", "off", "Position", [1 1 450 500]);
subplot(6,1,1)
stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
title("in1");
xlim([0,tEnd])
ylim([0,1.3])

subplot(6,1,2)
stairs(simout.gen2Out.t,simout.gen2Out.y,'-*');
title("in2");
xlim([0,tEnd])
ylim([0,1.3])

subplot(6,1,3)
stairs(simout.gen3Out.t,simout.gen3Out.y,'-*');
title("in3");
xlim([0,tEnd])
ylim([0,1.3])

subplot(6,1,4)
stairs(simout.gen4Out.t,simout.gen4Out.y,'-*');
title("in4");
xlim([0,tEnd])
ylim([0,1.3])

subplot(6,1,5)
stairs(simout.nandOut.t,simout.nandOut.y,'-*');
title("out");
xlim([0,tEnd])
ylim([0,1.3])


