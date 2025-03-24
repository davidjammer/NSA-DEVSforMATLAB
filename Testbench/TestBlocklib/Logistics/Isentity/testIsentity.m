function out = testIsentity(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 12;
  model_generator("Isentity_Model");
  out = model_simulator("Isentity_Model", tEnd);

  if showPlot
    figure("name", "testIsentity", "Position",[1 1 450 500]);
    tiledlayout("vertical")

    nexttile
    stem(out.inVal.t,out.inVal.y, "b");
    hold("on")
    stem(out.inEnt.t, [out.inEnt.y.id], "r*");
    hold("off")
    grid("on");
    xlim([0, tEnd])
    title("In");
    legend("val", "ent", "Location", "best", ...
      "Position",[0.556 0.630 0.149 0.065]);

    nexttile
    stem(out.Out.t,out.Out.y);
    grid("on");
    xlim([0, tEnd])
    title("Out");
  end

end