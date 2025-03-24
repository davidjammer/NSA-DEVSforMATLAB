function [out]=testAddN4(showPlot)
  if nargin == 0
    showPlot = false;
  end

  % makes and runs model and plots results
  model = "AddN4_Model";
  tEnd = 6;

  model_generator(model);
  out = model_simulator(model, tEnd);
  if showPlot
    figure("name", "testAddN", "NumberTitle", "off")
    stem(out.sum.t,out.sum.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("testAddN");
  end
end
