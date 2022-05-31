function testhalfadder()
clear all;
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [1, 2, 3, 6];
yVec1 = [0, 1, 0, 1];
tVec2 = [1, 4, 5, 6];
yVec2 = [0, 1, 0, 1];
tEnd = 15;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Vectorgen2 = devs(vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
Ha = halfadderCM("ha", [0, 1], mdebug);
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Terminator2 = devs(terminator1("Terminator2", "tOut", 0, [0, rOut]));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
HaSout = devs(toworkspace("HaSout", "hasOut", 0, [0, rOut]));
HaCout = devs(toworkspace("HaCout", "hacOut", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Vectorgen2);
N1.add_model(Ha);
N1.add_model(Terminator1);
N1.add_model(Terminator2);
N1.add_model(Gen1out);
N1.add_model(Gen2out);
N1.add_model(HaSout);
N1.add_model(HaCout);

N1.add_coupling("Vectorgen1","out","ha","in1");
N1.add_coupling("Vectorgen2","out","ha","in2");
N1.add_coupling("ha","s","Terminator1","in");
N1.add_coupling("ha","c","Terminator2","in");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("Vectorgen2","out","Gen2out","in");
N1.add_coupling("ha","s","HaSout","in");
N1.add_coupling("ha","c","HaCout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testhalfadder", "NumberTitle", "off", "Position", [1 1 450 500]);
subplot(4,1,1)
stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
title("Generator 1");
xlim([0,16])
ylim([0,1.3])

subplot(4,1,2)
stairs(simout.gen2Out.t,simout.gen2Out.y,'-*');
title("Generator 2");
xlim([0,16])
ylim([0,1.3])

subplot(4,1,3)
stairs(simout.hasOut.t,simout.hasOut.y,'-*');
title("s");
xlim([0,16])
ylim([0,1.3])

subplot(4,1,4)
stairs(simout.hacOut.t,simout.hacOut.y,'-*');
title("c");
xlim([0,16])
ylim([0,1.3])

