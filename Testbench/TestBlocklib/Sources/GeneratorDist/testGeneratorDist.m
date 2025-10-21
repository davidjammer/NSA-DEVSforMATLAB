function [out] = testGeneratorDist(showPlot)
  if nargin == 0
    showPlot = false;
  end
  
  model = "GeneratorDist_Model";
  tEnd = 10;

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 500;
    height = 300;
    fig = figure("name", "testGeneratorDist", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("testGeneratorDist");
  end 
end