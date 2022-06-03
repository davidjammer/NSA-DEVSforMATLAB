function fifo3A()
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

nG = 20; %13;
tG = 1;
tS = 4.5;
mdebug = false;
tEnd = 38; %25;
rDist = [0, 4];
rOut = 100.0;

N1 = coordinator("N1");

Generator = devs(generator1("Generator", tG, 1, nG, [0, 1], mdebug));
Distribute3 = devs(distribute3("Distribute3", 1, [0, rDist], mdebug));
NQ1 = queueserverCM("NQ1", tS, [0, 1], [0, rOut], mdebug);
NQ2 = queueserverCM("NQ2", tS, [0, 1], [0, rOut], mdebug);
NQ3 = queueserverCM("NQ3", tS, [0, 1], [0, rOut], mdebug);
Combine3 = devs(combine3("Combine3", [0, 1], mdebug));
Smallestin = devs(smallestin3("Smallestin", [0, 1], mdebug));
Terminator = devs(terminator("Terminator", [0, 1], mdebug));
QsNout1 = devs(toworkspace("QsNout1", "qsNOut1", 0, [0, rOut]));
QsNout2 = devs(toworkspace("QsNout2", "qsNOut2", 0, [0, rOut]));
QsNout3 = devs(toworkspace("QsNout3", "qsNOut3", 0, [0, rOut]));
Combout = devs(toworkspace("Combout", "combOut", 0, [0, rOut]));

N1.add_model(Generator);
N1.add_model(Distribute3);
N1.add_model(NQ1);
N1.add_model(NQ2);
N1.add_model(NQ3);
N1.add_model(Combine3);
N1.add_model(Smallestin);
N1.add_model(Terminator);
N1.add_model(QsNout1);
N1.add_model(QsNout2);
N1.add_model(QsNout3);
N1.add_model(Combout);

N1.add_coupling("Generator","out","Distribute3","in");
N1.add_coupling("Distribute3","out1","NQ1","in");
N1.add_coupling("Distribute3","out2","NQ2","in");
N1.add_coupling("Distribute3","out3","NQ3","in");
N1.add_coupling("NQ1","out","Combine3","in1");
N1.add_coupling("NQ2","out","Combine3","in2");
N1.add_coupling("NQ3","out","Combine3","in3");
N1.add_coupling("Combine3","out","Terminator","in");
N1.add_coupling("NQ1","n","Smallestin","in1");
N1.add_coupling("NQ2","n","Smallestin","in2");
N1.add_coupling("NQ3","n","Smallestin","in3");
N1.add_coupling("Smallestin","out","Distribute3","port");
N1.add_coupling("NQ1","n","QsNout1","in");
N1.add_coupling("NQ2","n","QsNout2","in");
N1.add_coupling("NQ3","n","QsNout3","in");
N1.add_coupling("Combine3","out","Combout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name","fifo3A", "NumberTitle","off", "Position",[1 1 450 650]);
subplot(3,1,1)
stem(simout.combOut.t,simout.combOut.y);
grid("on");
xlim([0, tEnd])
ylabel("out");
title("outgoing entities");

subplot(3,1,2)
stairs(simout.NQ1_qnOut.t,simout.NQ1_qnOut.y);
hold('on')
stairs(simout.NQ2_qnOut.t,simout.NQ2_qnOut.y);
stairs(simout.NQ3_qnOut.t,simout.NQ3_qnOut.y);
hold('off')
grid("on");
xlim([0, tEnd])
ylim([0, 3.2])
ylabel("n");
title("queue lengths");

subplot(3,1,3)
stairs(simout.qsNOut1.t,simout.qsNOut1.y);
hold('on')
stairs(simout.qsNOut2.t,simout.qsNOut2.y);
stairs(simout.qsNOut3.t,simout.qsNOut3.y);
hold('off')
grid("on");
xlim([0, tEnd])
ylim([0, 4.2])
ylabel("n");
title("queue+server loads");
