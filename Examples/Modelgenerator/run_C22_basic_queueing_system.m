clear all;

global simout
global DEBUGLEVEL

DEBUGLEVEL = 0;

addpath("out");
N0 = build_C22_basic_queueing_system();
rmpath("out");


root = rootcoordinator("root",0,140,N0,0,1);

root.sim();


figure
subplot(1,2,1);
stem(simout.output.t,simout.output.y);
title("outgoing entities");
ylabel("ids");
xlim([94.5 120]);
ylim([79.5 100]);

subplot(1,2,2);
stairs(simout.SUM_N.t,simout.SUM_N.y);
title("total queue length");
ylabel("l_{qt}");

