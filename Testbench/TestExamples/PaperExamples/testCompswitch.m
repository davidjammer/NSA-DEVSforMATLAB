function out = testCompswitch(showPlot)
  if ~exist('showPlot','var')
    showPlot = false;
  end

  model = "compswitch";
  tEnd = 17.5;

  addpath("../Examples/PaperExamples/atomics");
  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    plotResults(out, tEnd)
  end
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
  figure("name", "compswitch", "NumberTitle", "off", ...
    "Position", [1 1 450 600]);
  subplot(4,1,1)
  stem(out.vgenOut.t,out.vgenOut.y);
  grid("on");
  xlim([0, tEnd])
  ylim([-3.4, 2.4])
  ylabel("out");
  title("VectorGen");

  subplot(4,1,2)
  plot_ieee1164(out.compOut.t,out.compOut.y, ["0","1"])
  grid("on");
  xlim([0, tEnd])
  ylabel("out");
  title("Comparator");

  subplot(4,1,3)
  stem(out.sw1Out.t,out.sw1Out.y);
  grid("on");
  xlim([0, tEnd])
  ylim([-3.4, 2.4])
  ylabel("out1");
  title("Switch 1");

  subplot(4,1,4)
  stem(out.sw2Out.t,out.sw2Out.y);
  grid("on");
  xlim([0, tEnd])
  ylim([-3.4, 2.4])
  ylabel("out2");
  title("Switch 2");
end
