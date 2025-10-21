function [out] = testGeneratorDist1(showPlot)
  if nargin == 0
    showPlot = false;
  end
  
  model = "GeneratorDist1_Model";
  tEnd = 8;

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 500;
    height = 300;
    fig = figure("name", "testGeneratorDist1", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 10]);
    xlabel("simulation time");
    ylabel("out");
    title("testGeneratorDist1");
  end 
end