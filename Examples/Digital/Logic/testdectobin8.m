function testdectobin8()
clear all;
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [0:1:255];
yVec1 = [0:1:255];



tEnd = 256;
mdebug = false;
rOut = 0.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));

Dectobin8 = devs(dectobin8("dectobin8", [0, 1], mdebug));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Dectobin8out_0 = devs(toworkspace("Dectobin8out_0", "dectobin8Out0", 0, [0, rOut]));
Dectobin8out_1 = devs(toworkspace("Dectobin8out_1", "dectobin8Out1", 0, [0, rOut]));
Dectobin8out_2 = devs(toworkspace("Dectobin8out_2", "dectobin8Out2", 0, [0, rOut]));
Dectobin8out_3 = devs(toworkspace("Dectobin8out_3", "dectobin8Out3", 0, [0, rOut]));
Dectobin8out_4 = devs(toworkspace("Dectobin8out_4", "dectobin8Out4", 0, [0, rOut]));
Dectobin8out_5 = devs(toworkspace("Dectobin8out_5", "dectobin8Out5", 0, [0, rOut]));
Dectobin8out_6 = devs(toworkspace("Dectobin8out_6", "dectobin8Out6", 0, [0, rOut]));
Dectobin8out_7 = devs(toworkspace("Dectobin8out_7", "dectobin8Out7", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Dectobin8);
N1.add_model(Gen1out);
N1.add_model(Dectobin8out_0);
N1.add_model(Dectobin8out_1);
N1.add_model(Dectobin8out_2);
N1.add_model(Dectobin8out_3);
N1.add_model(Dectobin8out_4);
N1.add_model(Dectobin8out_5);
N1.add_model(Dectobin8out_6);
N1.add_model(Dectobin8out_7);

N1.add_coupling("Vectorgen1","out","dectobin8","in1");

N1.add_coupling("Vectorgen1","out","Gen1out","in");

N1.add_coupling("dectobin8","out1","Dectobin8out_0","in");
N1.add_coupling("dectobin8","out2","Dectobin8out_1","in");
N1.add_coupling("dectobin8","out3","Dectobin8out_2","in");
N1.add_coupling("dectobin8","out4","Dectobin8out_3","in");
N1.add_coupling("dectobin8","out5","Dectobin8out_4","in");
N1.add_coupling("dectobin8","out6","Dectobin8out_5","in");
N1.add_coupling("dectobin8","out7","Dectobin8out_6","in");
N1.add_coupling("dectobin8","out8","Dectobin8out_7","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testNand2", "NumberTitle", "off", "Position", [1 1 450 500]);
subplot(9,1,1)
stairs(simout.gen1Out.t,simout.gen1Out.y,'-*');
title("Generator 1");
xlim([0,tEnd])
ylim([0,20])

subplot(9,1,2)
stairs(simout.dectobin8Out0.t,simout.dectobin8Out0.y,'-*');
title("bin0");
xlim([0,tEnd])
ylim([0,1.3])

subplot(9,1,3)
stairs(simout.dectobin8Out1.t,simout.dectobin8Out1.y,'-*');
title("bin1");
xlim([0,tEnd])
ylim([0,1.3])

subplot(9,1,4)
stairs(simout.dectobin8Out2.t,simout.dectobin8Out2.y,'-*');
title("bin2");
xlim([0,tEnd])
ylim([0,1.3])

subplot(9,1,5)
stairs(simout.dectobin8Out3.t,simout.dectobin8Out3.y,'-*');
title("bin3");
xlim([0,tEnd])
ylim([0,1.3])

subplot(9,1,6)
stairs(simout.dectobin8Out4.t,simout.dectobin8Out4.y,'-*');
title("bin4");
xlim([0,tEnd])
ylim([0,1.3])

subplot(9,1,7)
stairs(simout.dectobin8Out5.t,simout.dectobin8Out5.y,'-*');
title("bin5");
xlim([0,tEnd])
ylim([0,1.3])

subplot(9,1,8)
stairs(simout.dectobin8Out6.t,simout.dectobin8Out6.y,'-*');
title("bin6");
xlim([0,tEnd])
ylim([0,1.3])

subplot(9,1,9)
stairs(simout.dectobin8Out7.t,simout.dectobin8Out7.y,'-*');
title("bin7");
xlim([0,tEnd])
ylim([0,1.3])
