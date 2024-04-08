function runTimeSharedStat()
% makes and runs model and plots results
% optional: 
%   set global DEBUGLEVEL
%   model_simulator(model, tEnd, false)
model = "timeSharedStat";
rng(3);     % set seed for random generator
tEnd = 1400;
displayFlag = false;     % show timestamps

% set parameters
tW = 25;
tS = 0.8;
q = 0.1;
tSwap = 0.015;
NJ = 1000;

load_system(model);
hBlock = getSimulinkBlockHandle("timeSharedStat/Terminals", true);
set_param(hBlock, "tW", string(tW))
set_param(hBlock, "tS", string(tS))
hBlock2 = getSimulinkBlockHandle("timeSharedStat/CPU", true);
set_param(hBlock2, "q", string(q))
set_param(hBlock2, "tSwap", string(tSwap))
hBlock3 = getSimulinkBlockHandle("timeSharedStat/NJ", true);
set_param(hBlock3, "value", string(NJ))

fprintf("\n  N     tR_avg    nQ_avg   util     runtime\n")
fprintf("=============================================\n")

for N = 10:10:80
  set_param(hBlock, "N", string(N))
  model_generator(model);
  tic;
  out = model_simulator(model, tEnd, true, displayFlag);
  tCPU = toc;
  showStatistics(out, N, tCPU)
end

end

%---------------------------------------------------------------------------
function showStatistics(out, N, tCPU)
  fprintf("  %2d   %6.3f    %6.3f    %5.3f    %5.2f\n", N, out.tRMean.y(end), ...
    out.nQMean.y(end), out.util.y(end), tCPU)
end