function testNotgate()
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

s0 = 1;
tVec = [2, 4, 7.5, 8.5];
tEnd = 14;
mdebug = false;
rOut = 3.0;

N1 = coordinator('N1');

Bingenerator = devs(bingenerator("Bingenerator", s0, tVec, [0,1], mdebug));
Notgate = devs(notgate("Notgate", [0,1], mdebug));
Terminator = devs(terminator1("Terminator", "termOut", 0, [0,rOut]));
Binout = devs(toworkspace("Binout", "binOut", 0, [0,rOut]));
Notout = devs(toworkspace("Notout", "notOut", 0, [0,rOut]));

N1.add_model(Bingenerator);
N1.add_model(Notgate);
N1.add_model(Terminator);
N1.add_model(Binout);
N1.add_model(Notout);

N1.add_coupling("Bingenerator","out","Notgate","in");
N1.add_coupling("Notgate","out","Terminator","in");
N1.add_coupling("Bingenerator","out","Binout","in");
N1.add_coupling("Notgate","out","Notout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testNotgate", "NumberTitle", "off")
subplot(2,1,1)
stairs(simout.binOut.t,simout.binOut.y);
hold("on");plot(simout.binOut.t,simout.binOut.y, "*");hold("off");
grid("on");
xlabel("simulation time");
ylabel("out");
title("Bingenerator");
xlim([0, tEnd])
ylim([-0.1, max(simout.binOut.y) + 0.1])

subplot(2,1,2)
stairs(simout.notOut.t,simout.notOut.y);
hold("on");plot(simout.notOut.t,simout.notOut.y, "*");hold("off");
grid("on");
xlabel("simulation time");
ylabel("out");
title("Not");
xlim([0, tEnd])
ylim([-0.1, 1.1])

