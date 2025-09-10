function [out] = testTerminator(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 12;

  model_generator("Terminator_Model");
  out = model_simulator("Terminator_Model", tEnd);

  if showPlot
    figure("name", "testTerminator", "NumberTitle", "off")
    tiledlayout("vertical")

    nexttile()
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 15]);
    xlabel("t");
    ylabel("gen out");

    nexttile()
    stem(out.termOut.t,out.termOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 15]);
    xlabel("t");
    ylabel("term out");
  end
end