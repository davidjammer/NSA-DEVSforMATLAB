function [out]=testAddN4a(showPlot)
  if nargin == 0
    showPlot = false;
  end

  % makes and runs model and plots results
  model = "AddN4a_Model";
  tEnd = 6;

  model_generator(model);
  out = model_simulator(model, tEnd);
  if showPlot
    figure("name", "testAddNa", "NumberTitle", "off")
    stem(out.sum.t,out.sum.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("testAddN");
  end
end
