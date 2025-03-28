function [out]=testCollectN(showPlot)
  % uses explicit cm model file
  if nargin == 0
    showPlot = false;
  end

  model = "CollectN_Model";
  N = 10;
  tEnd = 2*N + 10;
  
  % no model builder
  out = my_model_simulator(model, tEnd, N);

  if showPlot
    figure("name", "testCollectN", "NumberTitle", "off")
    stem(out.combOut.t,out.combOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("testCollectN");
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
