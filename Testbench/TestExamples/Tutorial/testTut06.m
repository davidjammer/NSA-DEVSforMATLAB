function out = testTut06(showPlot)
  if ~exist('showPlot','var')
    showPlot = false;
  end

  model = "tut06d";
  tEnd = 13;
  rng(3);

  model_generator(model);
  out = model_simulator(model, tEnd);
  if showPlot
    plotResults(out, tEnd)
  end
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
t = tiledlayout(2,2);
t.TileSpacing = "compact";
t.Padding = "compact";

nexttile()
stem(out.gen.t,out.gen.y);
grid("on");
xlim([0, tEnd])
title("Generator out");
xlabel("t")

nexttile()
stem(out.qIn.t,[out.qIn.y.id]);
grid("on");
xlim([0, tEnd])
title("Queue in");
xlabel("t")

nexttile()
stem(out.qOut.t,[out.qOut.y.id]);
grid("on");
xlim([0, tEnd])
title("Queue out");
xlabel("t")

nexttile()
stem(out.sysOut.t,[out.sysOut.y.id]);
grid("on");
xlim([0, tEnd])
title("System out");
xlabel("t")
end
