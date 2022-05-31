function testSmallestin3()
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec1 = [1, 3, 5, 7, 9];
yVec1 = [2, 3, 2, 5, 7];
tVec2 = [1, 3, 5, 7.3, 9.3];
yVec2 = [1, 2, 3, 6, 7];
tVec3 = [1, 3, 5, 7.6, 9.6];
yVec3 = [3, 1, 4, 7, 5];
tEnd = 11.6;
mdebug = false;
rOut = 3.0;

N1 = coordinator("N1");

Vectorgen1 = devs(vectorgen("Vectorgen1", tVec1, yVec1, [0, 1], mdebug));
Vectorgen2 = devs(vectorgen("Vectorgen2", tVec2, yVec2, [0, 1], mdebug));
Vectorgen3 = devs(vectorgen("Vectorgen3", tVec3, yVec3, [0, 1], mdebug));
Smallestin = devs(smallestin3("Smallestin", [0, 1], mdebug));
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Gen1out = devs(toworkspace("Gen1out", "gen1Out", 0, [0, rOut]));
Gen2out = devs(toworkspace("Gen2out", "gen2Out", 0, [0, rOut]));
Gen3out = devs(toworkspace("Gen3out", "gen3Out", 0, [0, rOut]));
Smallout = devs(toworkspace("Smallout", "smallOut", 0, [0, rOut]));

N1.add_model(Vectorgen1);
N1.add_model(Vectorgen2);
N1.add_model(Vectorgen3);
N1.add_model(Smallestin);
N1.add_model(Terminator1);
N1.add_model(Gen1out);
N1.add_model(Gen2out);
N1.add_model(Gen3out);
N1.add_model(Smallout);

N1.add_coupling("Vectorgen1","out","Smallestin","in1");
N1.add_coupling("Vectorgen2","out","Smallestin","in2");
N1.add_coupling("Vectorgen3","out","Smallestin","in3");
N1.add_coupling("Smallestin","out","Terminator1","in");
N1.add_coupling("Vectorgen1","out","Gen1out","in");
N1.add_coupling("Vectorgen2","out","Gen2out","in");
N1.add_coupling("Vectorgen3","out","Gen3out","in");
N1.add_coupling("Smallestin","out","Smallout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testSmallestin3", "NumberTitle", "off", ...
  "Position", [1 1 450 500]);
subplot(4,1,1)
stem(simout.gen1Out.t,simout.gen1Out.y);
title("Generator 1");
xlim([0,12])
ylim([0,8])

subplot(4,1,2)
stem(simout.gen2Out.t,simout.gen2Out.y);
title("Generator 2");
xlim([0,12])
ylim([0,8])

subplot(4,1,3)
stem(simout.gen3Out.t,simout.gen3Out.y);
title("Generator 3");
xlim([0,12])
ylim([0,8])

subplot(4,1,4)
stem(simout.smallOut.t,simout.smallOut.y);
title("Smallestin 3");
xlim([0,12])
ylim([0,4])
