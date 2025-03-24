function [out]= testCollect2a(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tend = 10;
  model_generator("Collect2a_Model");
  out = model_simulator("Collect2a_Model", tend);

  if showPlot
    figure("name", "testCollect2a", "Position", [1 1 450 500]);
    tiledlayout("vertical")

    nexttile
    stem(out.gen1Out.t, [out.gen1Out.y.id]);
    title("Generator 1");
    xlim([0,tend])

    nexttile
    stem(out.gen2Out.t, [out.gen2Out.y.id]);
    title("Generator 2");
    xlim([0,tend])

    nexttile
    stem(out.combOut.t, [out.combOut.y.id]);
    title("Collect2");
    xlim([0,tend])
  end
end
