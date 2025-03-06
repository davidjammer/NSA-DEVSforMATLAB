function [out] = testSmallestinN4(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 11.6;
  model_generator("SmallestinN4_Model");
  out = model_simulator("SmallestinN4_Model", tEnd);

  if showPlot
    figure("name", "testSmallestinN4", "NumberTitle", "off", ...
      "Position", [1 1 450 700]);
    subplot(5,1,1)
    stem(out.gen1Out.t,out.gen1Out.y);
    title("Generator 1");
    xlim([0,tEnd])
    ylim([0,8])

    subplot(5,1,2)
    stem(out.gen2Out.t,out.gen2Out.y);
    title("Generator 2");
    xlim([0,tEnd])
    ylim([0,8])

    subplot(5,1,3)
    stem(out.gen3Out.t,out.gen3Out.y);
    title("Generator 3");
    xlim([0,tEnd])
    ylim([0,8])

    subplot(5,1,4)
    stem(out.gen4Out.t,out.gen4Out.y);
    title("Generator 4");
    xlim([0,tEnd])
    ylim([0,10])

    subplot(5,1,5)
    stem(out.smallOut.t,out.smallOut.y);
    title("Smallestin N");
    xlim([0,tEnd])
    ylim([0,4])
  end
end
