function [out] = testDistribute2(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tend = 15;
  model_generator("Distribute2_Model");
  out = model_simulator("Distribute2_Model", tend);

  if showPlot
    figure("name", "testDistribute2", "NumberTitle", "off", ...
      "Position",[1 1 550 575]);
    subplot(2,2,1)
    stem(out.genOut.t,out.genOut.y);
    grid("on");
    xlim([0, tend])
    ylabel("out");
    title("Generator");

    subplot(2,2,3)
    stairs(out.vgenOut.t,out.vgenOut.y);
    hold("on");plot(out.vgenOut.t,out.vgenOut.y, "*");hold("off");
    grid("on");
    xlim([0, tend])
    ylim([0.8, 2.2])
    ylabel("out");
    title("Distributor port");

    subplot(2,2,2)
    stem(out.dist1Out.t,out.dist1Out.y);
    grid("on");
    xlim([0, tend])
    ylim([0, 15])
    ylabel("out1");
    title("Distributor");

    subplot(2,2,4)
    stem(out.dist2Out.t,out.dist2Out.y);
    grid("on");
    xlim([0, tend])
    ylim([0, 15])
    ylabel("out2");
    title("Distributor");
  end

end
