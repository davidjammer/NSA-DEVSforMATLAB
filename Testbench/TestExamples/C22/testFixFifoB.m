function out = testFixFifoB(showPlot)
  if ~exist('showPlot','var')
    showPlot = false;
  end

  model = "fixFifoB";
  tEnd = 140;
  
  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    allXacts = [out.output.t', out.output.y'];
    qAll = [out.SUM_N.t', out.SUM_N.y'];
    qWaits = [0,0];    % dummy
    plotStatBench(qAll, allXacts, qWaits, 1)
  end
end
