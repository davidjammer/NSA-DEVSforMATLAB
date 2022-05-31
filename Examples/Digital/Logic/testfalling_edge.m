function testfalling_edge()
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
tEnd = 15;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Fe = falling_edgeCM("fe", [0, 1], mdebug);
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Feout = devs(toworkspace("Feout", "feOut", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Fe);
N1.add_model(Terminator1);
N1.add_model(Gen1out);
N1.add_model(Feout);

N1.add_coupling("Vectorgen1","out","fe","in1");
N1.add_coupling("fe","out","Terminator1","in");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("fe","out","Feout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "test falling edge", "NumberTitle", "off", "Position", [1 1 450 500]);
subplot(2,1,1)
stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
title("in");
xlim([0,16])
ylim([0,1.3])

subplot(2,1,2)
stairs(simout.feOut.t,simout.feOut.y,'-*');
title("fe");
xlim([0,16])
ylim([0,1.3])


