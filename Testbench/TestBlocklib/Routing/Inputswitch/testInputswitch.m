function [out] = testInputswitch(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 17.5;
  model_generator("Inputswitch_Model");
  out = model_simulator("Inputswitch_Model", tEnd);

  if showPlot
    figure("name", "testInputswitch", "Position",[1 1 450 600]);
    tiledlayout("vertical")

    nexttile
    stem(out.in1.t,out.in1.y);
    xlim([0, tEnd])
    %ylim([0, 18])
    title("Input 1");

    nexttile
    stem(out.in2.t,out.in2.y);
    xlim([0, tEnd])
    %ylim([0, 18])
    title("Input 2");

    nexttile
    stairs(out.sw.t,out.sw.y);
    hold("on");plot(out.sw.t,out.sw.y, "*");hold("off");
    grid("on");
    xlim([0, tEnd])
    ylim([-0.1, 1.1])
    title("Switch");

    nexttile
    stem(out.out.t,out.out.y);
    xlim([0, tEnd])
    %ylim([0, 18])
    title("Out");
  end
end