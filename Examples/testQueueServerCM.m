function testQueueServerCM()
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tG = 1;
nG = 5;
tS = 1.5;
mdebug = false;
tEnd = 9;
rOut = 3.0;

N1 = coordinator("N1");
N2 = queueserverCM("N2", tS, [0, 1], [0, rOut], mdebug);

Generator = devs(generator1("Generator", tG, 1, nG, [0, 1], mdebug));
Terminator1 = devs(terminator("Terminator1", [0, 1], mdebug));
Terminator2 = devs(terminator("Terminator2", [0, 1], mdebug));
Genout = devs(toworkspace("Genout", "genOut", 0, [0, rOut]));
Qsout = devs(toworkspace("Qsout", "qsOut", 0, [0, rOut]));
QsNout = devs(toworkspace("QsNout", "qsNOut", 0, [0, rOut]));

N1.add_model(Generator);
N1.add_model(N2);
N1.add_model(Terminator1);
N1.add_model(Terminator2);
N1.add_model(Genout);
N1.add_model(Qsout);
N1.add_model(QsNout);

N1.add_coupling("Generator","out","N2","in");
N1.add_coupling("N2","out","Terminator1","in");
N1.add_coupling("N2","n","Terminator2","in");
N1.add_coupling("Generator","out","Genout","in");
N1.add_coupling("N2","out","Qsout","in");
N1.add_coupling("N2","n","QsNout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testQueueServerCM", "NumberTitle", "off", ...
  "Position", [1 1 450 650]);
subplot(3,1,1)
stem(simout.genOut.t,simout.genOut.y);
grid("on");
xlim([0, tEnd])
ylabel("out");
title("Generator");

subplot(3,1,2)
stem(simout.qsOut.t,simout.qsOut.y);
grid("on");
xlim([0, tEnd])
ylabel("out");
title("Server");

subplot(3,1,3)
stairs(simout.qsNOut.t,simout.qsNOut.y);
hold("on");plot(simout.qsNOut.t,simout.qsNOut.y, "*");hold("off");
grid("on");
xlim([0, tEnd])
ylim([0, 3.2])
ylabel("n");
title("Queue-Server Load");
