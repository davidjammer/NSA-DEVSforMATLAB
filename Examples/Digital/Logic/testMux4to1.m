function testMux4to1()
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

tVec5 = [0, 16, 32, 48, 96];
yVec5 = [0,  1,  0,  1,  0];
tVec6 = [0, 16, 32, 48, 96];
yVec6 = [0,  0,  1,  1,  0];
tEnd = 100;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Vectorgen2 = devs(vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
Vectorgen3 = devs(vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
Vectorgen4 = devs(vectorgen("Vectorgen4", tVec4, yVec4, [0, 1], mdebug));
Vectorgen5 = devs(vectorgen("Vectorgen5", tVec5, yVec5, [0, 1], mdebug));
Vectorgen6 = devs(vectorgen("Vectorgen6", tVec6, yVec6, [0, 1], mdebug));
Mux = mux4to1CM("Mux", [0, 1], mdebug);
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
Gen3out = devs(toworkspace("Gen3out", "gen3Out", 0, [0, rOut]));
Gen4out = devs(toworkspace("Gen4out", "gen4Out", 0, [0, rOut]));
Gen5out = devs(toworkspace("Gen5out", "gen5Out", 0, [0, rOut]));
Gen6out = devs(toworkspace("Gen6out", "gen6Out", 0, [0, rOut]));
Muxout = devs(toworkspace("Muxout", "muxOut", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Vectorgen2);
N1.add_model(Vectorgen3);
N1.add_model(Vectorgen4);
N1.add_model(Vectorgen5);
N1.add_model(Vectorgen6);
N1.add_model(Mux);
N1.add_model(Gen1out);
N1.add_model(Gen2out);
N1.add_model(Gen3out);
N1.add_model(Gen4out);
N1.add_model(Gen5out);
N1.add_model(Gen6out);
N1.add_model(Muxout);

N1.add_coupling("Vectorgen1","out","Mux","in1");
N1.add_coupling("Vectorgen2","out","Mux","in2");
N1.add_coupling("Vectorgen3","out","Mux","in3");
N1.add_coupling("Vectorgen4","out","Mux","in4");
N1.add_coupling("Vectorgen5","out","Mux","sel1");
N1.add_coupling("Vectorgen6","out","Mux","sel2");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("Vectorgen2","out","Gen2out","in");
N1.add_coupling("Vectorgen3","out","Gen3out","in");
N1.add_coupling("Vectorgen4","out","Gen4out","in");
N1.add_coupling("Vectorgen5","out","Gen5out","in");
N1.add_coupling("Vectorgen6","out","Gen6out","in");
N1.add_coupling("Mux","q","Muxout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testMux4to1", "NumberTitle", "off", "Position", [1 1 450 500]);
subplot(7,1,1)
stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
title("in1");
xlim([0,tEnd])
ylim([0,1.3])

subplot(7,1,2)
stairs(simout.gen2Out.t,simout.gen2Out.y,'-*');
title("in2");
xlim([0,tEnd])
ylim([0,1.3])

subplot(7,1,3)
stairs(simout.gen3Out.t,simout.gen3Out.y,'-*');
title("in3");
xlim([0,tEnd])
ylim([0,1.3])

subplot(7,1,4)
stairs(simout.gen4Out.t,simout.gen4Out.y,'-*');
title("in4");
xlim([0,tEnd])
ylim([0,1.3])

subplot(7,1,5)
stairs(simout.gen5Out.t,simout.gen5Out.y,'-*');
title("sel1");
xlim([0,tEnd])
ylim([0,1.3])

subplot(7,1,6)
stairs(simout.gen6Out.t,simout.gen6Out.y,'-*');
title("sel2");
xlim([0,tEnd])
ylim([0,1.3])

subplot(7,1,7)
stairs(simout.muxOut.t,simout.muxOut.y,'-*');
title("q");
xlim([0,tEnd])
ylim([0,1.3])


