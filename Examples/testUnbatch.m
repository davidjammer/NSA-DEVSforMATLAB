function [out] = testUnbatch(tend)

global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.000;
simout = [];
DEBUGLEVEL = 0;
epsilon = 1e-6;

if(nargin ~= 1)
    tend = 40;
end

N1 = coordinator('N1');

Gen = devs(generator("Gen", 1, 0, Inf, [0,1], 0));
Bat = devs(batch("batch", 10, [0,1], 0));
Unbatch = devs(unbatch("unbatch", [0,1], [0,2], 0)); 
Fifo1 = devs(queue("fifo1", [0,1], [0,1], 0)); 
c0 = devs(const("c0", 1, [0,1], [0,1], 0));
ToWorkspace = devs(toworkspace('logunbatch', 'out', 0, "vektor", [0,0.5], 0));

N1.add_model(Gen);
N1.add_model(Bat);
N1.add_model(Unbatch);
N1.add_model(Fifo1);
N1.add_model(c0);
N1.add_model(ToWorkspace);

N1.add_coupling('Gen','out','batch','in');
N1.add_coupling('batch','out','unbatch','in');
N1.add_coupling('unbatch','out','fifo1','in');
N1.add_coupling('c0','out','fifo1','bl');
N1.add_coupling('unbatch','out','logunbatch','in');

root = rootcoordinator('root',0,tend,N1,0);
tic;
root.sim();
ta=toc

figure
stem(simout.out.t,simout.out.y); grid on;
xlim([0 tend]);
xlabel('simulation time');
title('unbatch out');

out = simout;
end
