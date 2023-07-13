function [out] = model1(tend)

global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;
epsilon = 1e-6;

if(nargin ~= 1)
    tend = 10;
end

N1 = coordinator('N1');

Gen = devs(generator("Gen",1,[0, 1]));
Bat = devs(batch("batch", [0,1], 0, 10));
Unstack = devs(unstack("unstack",[0, 2], 0)); 
Fifo1 = devs(queue("fifo1",[0, 1], 0)); 
c0 = devs(const("c0", [0, 1], 0, 1));

ToWorkspace = devs(toworkspace('logunstack','out',0,[0, 1]));

N1.add_model(Gen);
N1.add_model(Bat);
N1.add_model(Unstack);
N1.add_model(Fifo1);
N1.add_model(c0);
N1.add_model(ToWorkspace);

N1.add_coupling('Gen','out','batch','in');
N1.add_coupling('batch','out','unstack','in');
N1.add_coupling('unstack','out','fifo1','in');
N1.add_coupling('c0','out','fif01','bl');
N1.add_coupling('unstack','out','logunstack','in');

root = rootcoordinator('root',0,tend,N1,0);
tic;
root.sim();
ta=toc

figure
stem(simout.out.t,simout.out.y); grid on;
xlim([0 tend]);
xlabel('simulation time');
title('out');

out = simout;
end
