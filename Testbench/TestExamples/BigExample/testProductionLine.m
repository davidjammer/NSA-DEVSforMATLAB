function out = testProductionLine(showPlot)
  if ~exist('showPlot','var')
    showPlot = false;
  end
 
  model = "productionLine";
  tEnd = 60000;

  model_generator(model);
  out = model_simulator(model, tEnd);
  if showPlot
    plotResults(out, tEnd, model)
  end
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd, model)
  figure("name", model, "NumberTitle", "off",...
         "Position", [1 1 800 750]);
  subplot(2,3,1)
  stairs(out.loadPeak.t, out.loadPeak.y)
  title("loadPeak");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(2,3,2)
  stairs(out.pcStock.t, out.pcStock.y)
  title("pcStock");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(2,3,3)
  stairs(out.pcUtil.t, out.pcUtil.y)
  title("pcUtil");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(2,3,4)
  stairs(out.thrput.t, out.thrput.y)
  title("thrput");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(2,3,5)
  stairs(out.eSpec.t, out.eSpec.y)
  title("eSpec");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(2,3,6)
  stairs(out.procTime.t, out.procTime.y)
  title("procTime");
  xlabel("t [s]");
  xlim([0 tEnd]);

  figure("name", model+" ids", "NumberTitle", "off",...
         "Position", [1 1 600 400]);
  stem(out.eOut.t, out.eOut.y)
  title("eOut");
  xlabel("t [s]");
  xlim([0 tEnd]);
end
