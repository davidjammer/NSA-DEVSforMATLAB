function [out]=testGenerator(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 8;
  model_generator("Generator_Model");
  out = model_simulator("Generator_Model", tEnd);

  if showPlot
    width = 500;
    height = 300;
    fig = figure("name", "testGenerator1", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 9]);
    xlabel("simulation time");
    ylabel("out");
    title("testGenerator1");
  end
end
