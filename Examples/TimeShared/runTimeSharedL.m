function runTimeSharedL
% makes and runs model and plots results
% optional: 
%   set global DEBUGLEVEL
%   model_simulator(model, tEnd, false)
model = "timeSharedL";
tEnd = 1400;
seed = 3;

% set parameters
N = 20;
tW = 25;
tS = 0.8;
q = 0.1;
tSwap = 0.015;
NJ = 1000;

load_system(model);
hBlock = getSimulinkBlockHandle("timeSharedL/Terminals", true);
set_param(hBlock, "N", string(N))
set_param(hBlock, "tW", string(tW))
set_param(hBlock, "tS", string(tS))
hBlock = getSimulinkBlockHandle("timeSharedL/CPU", true);
set_param(hBlock, "q", string(q))
set_param(hBlock, "tSwap", string(tSwap))
hBlock = getSimulinkBlockHandle("timeSharedL/NJ", true);
set_param(hBlock, "value", string(NJ))

% create and run model
model_generator(model); 
out = model_simulator(model, tEnd, "seed", seed);
plotResults(out, tEnd)
showStatistics(out, tEnd)
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
figure("name","timeShared","NumberTitle","off", "Position",[1 1 400 550]);

subplot(3,1,1)
stairs(out.util.t,out.util.y);
grid("on");
xlim([0 tEnd]);
ylabel("util");
xlabel("t");
title("CPU utilization");

subplot(3,1,2)
plot(out.nQ.t,out.nQ.y, out.nQMean.t, out.nQMean.y);
grid("on");
xlim([0 tEnd]);
ylabel("n_Q");
xlabel("t");
title("Queue length, avg.");

subplot(3,1,3)
plot(out.tR.t,out.tR.y, out.tRMean.t,out.tRMean.y);
grid("on");
xlim([0 tEnd]);
ylabel("t_R");
xlabel("t");
title("Response time, avg");
end

function showStatistics(out, tEnd)
  fprintf("\nStatistics at t=%f:\n", tEnd)
  fprintf("  avg. response time:    %6.4f\n", out.tRMean.y(end))
  fprintf("  avg. queue length:     %6.4f\n", out.nQMean.y(end))
  fprintf("  CPU utilization:       %6.4f\n", out.util.y(end))

end