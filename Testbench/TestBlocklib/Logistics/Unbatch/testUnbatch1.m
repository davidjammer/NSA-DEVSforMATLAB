function [out] = testUnbatch1(testcase, showPlot)
  if ~exist("testcase", "var")
    testcase = 1;
  end
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  switch testcase
    case 1
      nBatch = 2;
    case 2
      nBatch = 1;
    otherwise
      nBatch = 2;
  end

  model = "Unbatch1_Model";
  tEnd = 7;
  load_system(model);
  set_param(model + "/am_batch", "N", string(nBatch));
  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 500;
    height = 500;
    fig = figure("name", "testReleaseQueue", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)
    tiledlayout("vertical")

    nexttile()
    stem(out.in.t,[out.in.y.value]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("batch in");

    nexttile()
    stem(out.batch.t,out.batch.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("batch out");

    nexttile()
    stem(out.out.t,[out.out.y.value]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("unbatch out");
  end
end
