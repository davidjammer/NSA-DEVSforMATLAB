function out = testTut05(showPlot)
  if ~exist('showPlot','var')
    showPlot = false;
  end

  model = "tut05";
  tEnd = 6;

  model_generator(model);
  out = model_simulator(model, tEnd);
  if showPlot
    plotResults(out, tEnd)
  end
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
tiledlayout("vertical")
nexttile
stem(out.in1.t,out.in1.y);
grid("on");
xlim([0, tEnd])
title("in_1");
xlabel("t")

nexttile
stem(out.in2.t,out.in2.y);
grid("on");
xlim([0, tEnd])
title("in_2");
xlabel("t")

nexttile
stem(out.out1.t,out.out1.y);
grid("on");
xlim([0, tEnd])
title("out_1");
xlabel("t")
end
