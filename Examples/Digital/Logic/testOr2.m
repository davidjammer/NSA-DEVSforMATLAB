function testOr2()
clear all;
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [0, 1, 2, 3, 6, 7];
yVec1 = [0, 0, 1, 0, 1, 0];
tVec2 = [0, 1, 4, 5, 6, 7];
yVec2 = [0, 0, 1, 0, 1, 0];
tEnd = 15;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Vectorgen2 = devs(vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
Or2 = or2CM("or2", [0, 1], mdebug);
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
Orout = devs(toworkspace("Orout", "orOut", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Vectorgen2);
N1.add_model(Or2);
N1.add_model(Terminator1);
N1.add_model(Gen1out);
N1.add_model(Gen2out);
N1.add_model(Orout);

N1.add_coupling("Vectorgen1","out","or2","in1");
N1.add_coupling("Vectorgen2","out","or2","in2");
N1.add_coupling("or2","out","Terminator1","in");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("Vectorgen2","out","Gen2out","in");
N1.add_coupling("or2","out","Orout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testOr2", "NumberTitle", "off", "Position", [1 1 450 500]);
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
stairs(simout.orOut.t,simout.orOut.y,'-*');
title("or2");
xlim([0,16])
ylim([0,1.3])


