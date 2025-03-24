function [out]=testAddN(showPlot)
  % uses explicit cm model file
  if nargin == 0
    showPlot = false;
  end

  model = "AddN_Model";
  N = 20;
  tEnd = N + 1;

  % no model builder
  out = my_model_simulator(model, tEnd, N);

  if showPlot
    figure("name", "testAddN", "NumberTitle", "off")
    stem(out.sum.t,out.sum.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("testAddN");
  end
end

function out = my_model_simulator(model, tEnd, N)
  % simplified simulator, works without previous builder
  global simout
  simout = [];
  N0 = eval("build_" + model +"(""model"", " + string(N) + ")");
  root = rootcoordinator("root", 0, tEnd, N0, 0, false);
  root.sim();
  out = simout;
end
