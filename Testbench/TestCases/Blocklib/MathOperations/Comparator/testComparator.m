function [out] = testComparator(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 17;
  model_generator("Comparator_Model");
  out = model_simulator("Comparator_Model", tEnd);

  if showPlot
    figure("name", "testComparator", "NumberTitle", "off", ...
      "Position", [1 1 450 500]);
    subplot(7,1,1)
    stem(out.genOut1.t,out.genOut1.y);
    hold on;
    stem(out.genOut2.t,out.genOut2.y);
    hold off;

    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("VectorGen");
    legend("in1","in2");

    subplot(7,1,2)
    stairs(out.compOut1.t, out.compOut1.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("in1>in2");

    subplot(7,1,3)
    stairs(out.compOut2.t, out.compOut2.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("in1<in2");

    subplot(7,1,4)
    stairs(out.compOut3.t, out.compOut3.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("in1>=in2");

    subplot(7,1,5)
    stairs(out.compOut4.t, out.compOut4.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("in1<=in2");

    subplot(7,1,6)
    stairs(out.compOut5.t, out.compOut5.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("in1==in2");

    subplot(7,1,7)
    stairs(out.compOut6.t, out.compOut6.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("in1~=in2");

    fprintf("in1:\t%2d %2d %2d %2d %2d %2d %2d %2d %2d %2d\n", out.genOut1.y);
    fprintf("in2:\t%2d %2d %2d %2d %2d %2d %2d %2d %2d %2d\n", out.genOut2.y);
    fprintf("> :\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", out.compOut1.y);
    fprintf("< :\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", out.compOut2.y);
    fprintf(">=:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", out.compOut3.y);
    fprintf("<=:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", out.compOut4.y);
    fprintf("==:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", out.compOut5.y);
    fprintf("~=:\t%2s %2s %2s %2s %2s %2s %2s %2s %2s %2s\n", out.compOut6.y);
  end
end
