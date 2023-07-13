function out = testConveyor(tEnd)
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tVec = [0,1, 5, 7, 8, 10];
yVec = [0,2, 2, 2, 2, 2];
g = 2;

mdebug = false;
rOut = 3.0;

N1 = coordinator("N1");

Vectorgen = devs(vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
Latency = devs(latency("Latency", [0, 1],mdebug, 2));
hInt = devs(hIntegrator("hInt", [0, 1], mdebug, 0.01, 0.001));
Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
Genout = devs(toworkspace("Genout", "genOut", 0, [0, rOut]));
hintout = devs(toworkspace("hintout", "hintOut", 0, [0, rOut]));

N1.add_model(Vectorgen);
N1.add_model(Latency);
N1.add_model(Terminator1);
N1.add_model(hintout);
N1.add_model(hInt);
N1.add_model(Genout);

N1.add_coupling("Vectorgen","out","Latency","in");
N1.add_coupling("Latency","out","hInt","in");
N1.add_coupling("hInt","out","Terminator","in");
N1.add_coupling("Vectorgen","out","Genout","in");
N1.add_coupling("hInt","out","hintout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();
out = simout;

figure("Position",[1 1 450 500]);
subplot(2,1,1)
stairs(simout.genOut.t,simout.genOut.y);
hold("on");plot(simout.genOut.t,simout.genOut.y, "*");hold("off");
grid("on");
xlim([0, tEnd])
ylim([-3.2, 2.2])
xlabel("simulation time");
ylabel("out");
title("mdot");

subplot(2,1,2)
stairs(simout.hintOut.t,simout.hintOut.y);
xlabel("simulation time");
ylabel("out");
title("m(t)");


end
