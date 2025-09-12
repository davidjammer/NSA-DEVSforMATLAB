function out = testUnbatch3(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  tEnd = 10;
  model_generator("Unbatch3_Model");
  out = model_simulator("Unbatch3_Model", tEnd);

  if showPlot
    width = 750;
    height = 650;
    fig = figure("name", "testReleaseQueue", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)
    tiledlayout(3,2)

    nexttile
    stem(out.in1.t,out.in1.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("in1");
 
    nexttile
    stem(out.in2.t,out.in2.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("in2");
 
    nexttile
    stem(out.batch1.t,out.batch1.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("batch1");
 
    nexttile
    stem(out.batch2.t,out.batch2.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("batch2");
 
    nexttile
    stem(out.out.t,out.out.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    title("out");
 end
end
