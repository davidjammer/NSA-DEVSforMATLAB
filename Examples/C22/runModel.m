function runModel(model)
% makes and runs model and plots results
% Demo: runModel("fixFifoA")

tEnd = 140;
 
model_generator(model);
out = model_simulator(model, tEnd);

% gather results and plot them
allXacts = [out.output.t', out.output.y'];
qAll = [out.SUM_N.t', out.SUM_N.y'];
qWaits = [0,0];  % dummy
plotStatBench(qAll, allXacts, qWaits, 1)
