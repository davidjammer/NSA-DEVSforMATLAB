function [out] = testUnbatch(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 40;
  model_generator("Unbatch_Model");
  out = model_simulator("Unbatch_Model", tEnd);

  if showPlot
    width = 600;
    height = 400;
    fig = figure("name", "testReleaseQueue", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    stem(out.out.t,out.out.y); grid on;
    xlim([0 tEnd]);
    xlabel('simulation time');
    title('unbatch out');
  end
end
