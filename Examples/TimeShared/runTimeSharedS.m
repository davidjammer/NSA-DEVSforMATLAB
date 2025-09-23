function runTimeSharedS
% makes and runs simple model and plots results
% optional: 
%   set global DEBUGLEVEL
%   model_simulator(model, tEnd, false)
model = "timeSharedS";
seed = 3;     % set seed for random generator
tEnd = 100;
displayFlag = false;     % show timestamps

% set parameters
N = 3;          % number of terminals
tW = 7;         % mean waiting time
tS = 5;         % mean service time
q = 1;          % time slice
tSwap = 0.1;    % swap time
NJ = 10;        % total number of finished jobs

load_system(model);
hBlock = getSimulinkBlockHandle("timeSharedS/Terminals", true);
set_param(hBlock, "N", string(N))
set_param(hBlock, "tW", string(tW))
set_param(hBlock, "tS", string(tS))
hBlock = getSimulinkBlockHandle("timeSharedS/CPU", true);
set_param(hBlock, "q", string(q))
set_param(hBlock, "tSwap", string(tSwap))
hBlock = getSimulinkBlockHandle("timeSharedS/NJ", true);
set_param(hBlock, "value", string(NJ))

% create and run model
model_generator(model); 
out = model_simulator(model, tEnd, "clearFlag", true, "displayFlag", displayFlag, "seed", seed);
plotResults(out, tEnd)
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
figure("name","timeShared","NumberTitle","off", "Position",[1 1 700 550]);

fs = 11;
subplot(3,2,1)
stem(out.termOut.t,[out.termOut.y.id]);
grid("on");
xlim([0 tEnd]);
ylabel("id", "FontSize", fs);
xlabel("t");
title("Jobs incoming");

subplot(3,2,2)
stem(out.termOut.t,[out.termOut.y.remainingServiceTime]);
grid("on");
xlim([0 tEnd]);
ylabel("t_S", "FontSize", fs);
xlabel("t");
title("Remaining time (before CPU)");

subplot(3,2,3)
stairs(out.nQ.t,out.nQ.y);
grid("on");
xlim([0 tEnd]);
ylabel("n_Q", "FontSize", fs);
xlabel("t");
title("Queue length");

subplot(3,2,4)
stem(out.cpuOut.t,[out.cpuOut.y.remainingServiceTime]);
grid("on");
xlim([0 tEnd]);
ylabel("t_{Rem}", "FontSize", fs);
xlabel("t");
title("Remaining time (after CPU)");

subplot(3,2,5)
stem(out.timeOut.t,out.timeOut.y);
grid("on");
xlim([0 tEnd]);
ylabel("t_R", "FontSize", fs);
xlabel("t");
title("Response time");

subplot(3,2,6)
stem(out.jobsOut.t,[out.jobsOut.y.id]);
grid("on");
xlim([0 tEnd]);
ylabel("id", "FontSize", fs);
xlabel("t");
title("Jobs outgoing");

end
