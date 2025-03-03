function [out] = testFiniteQueue(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 12;
  model_generator("FiniteQueue_Model");
  out = model_simulator("FiniteQueue_Model", tEnd);

  if showPlot
    % plot results
    width = 800;
    height = 800;
    screenSize = get(0, "ScreenSize");
    figureName = "testFiniteQueue";
    hFig = findobj("Type", "figure", "Name", figureName);
    if isempty(hFig)
      figure("name", figureName, "NumberTitle", "off", "Position", ...
        [screenSize(3)-width, screenSize(4)-height, width, height]);
    end
    t = tiledlayout(3,2);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile;
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylabel("out");
    title("Generator");

    nexttile;
    stairs(out.vgenOut.t, out.vgenOut.y); grid on;
    xlim([0 tEnd]);
    ylabel("in");
    title("Blocking in");

    nexttile;
    stem(out.queOut.t,[out.queOut.y.id]); grid on;
    xlim([0 tEnd]);
    ylabel("out");
    title("Queue out");

    nexttile;
    stairs(out.queNOut.t,out.queNOut.y); grid on;
    hold("on");plot(out.queNOut.t,out.queNOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylabel("nq");
    title("Queue length");

    nexttile;
    stairs(out.queFull.t,out.queFull.y); grid on;
    hold("on");plot(out.queFull.t,out.queFull.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1,1.1])
    ylabel("nq");
    title("Queue full");
  end
end