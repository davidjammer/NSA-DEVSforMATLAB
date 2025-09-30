function out = testTut02(showPlot)
  if ~exist('showPlot','var')
    showPlot = false;
  end

  model = "tut02";
  tEnd = 15;

  model_generator(model);
  out = model_simulator(model, tEnd, "seed", 3);
  if showPlot
    plotResults(out, tEnd)
  end
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
tiledlayout("vertical")
nexttile
stem(out.gen.t,out.gen.y);
grid("on");
xlim([0, tEnd])
title("Generator out");
xlabel("t")

nexttile
stem(out.srvIn.t,out.srvIn.y);
grid("on");
xlim([0, tEnd])
title("Queue out");
xlabel("t")

nexttile
stem(out.srvOut.t,out.srvOut.y);
grid("on");
xlim([0, tEnd])
title("Server out");
xlabel("t")
end
