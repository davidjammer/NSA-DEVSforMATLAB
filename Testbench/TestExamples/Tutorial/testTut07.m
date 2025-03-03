function out = testTut07(showPlot)
  if ~exist('showPlot','var')
    showPlot = false;
  end

  model = "tut07";
  tEnd = 50;
  rng(6)

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

nexttile
stem(out.gen.t,out.gen.y);
grid("on");
xlim([0, tEnd])
title("Generator out");
xlabel("t")

nexttile
stairs(out.isFull.t,str2double(out.isFull.y));
grid("on");
xlim([0, tEnd])
title("Queue isFull");
xlabel("t")
ylim([-0.1, 1.1])

nexttile
stem(out.srvOut.t,out.srvOut.y);
grid("on");
xlim([0, tEnd])
title("Server out");
xlabel("t")

nexttile
stairs(out.qLen.t,out.qLen.y);
grid("on");
xlim([0, tEnd])
title("Queue length");
xlabel("t")
end
