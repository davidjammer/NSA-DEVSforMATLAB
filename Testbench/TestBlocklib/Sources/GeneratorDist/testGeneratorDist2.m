function out = testGeneratorDist2(showPlot)
  if nargin == 0
    showPlot = false;
  end

  model = "GeneratorDist2_Model";
  tEnd = 10;
  seed = 3;

  model_generator(model);
  out = model_simulator(model, tEnd, "seed", seed);

  if showPlot
    width = 500;
    height = 300;
    fig = figure("name", "testGeneratorDist2", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 9]);
    xlabel("simulation time");
    ylabel("out");
    title("testGeneratorDist2");
  end
end