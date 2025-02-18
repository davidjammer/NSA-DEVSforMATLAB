function plotResults01(out, tEnd)
width = 450;
height = 600;
screenSize = get(0, "ScreenSize");
figureName = "tut01";

% open new figure only if necessary
hFig = findobj("Type", "figure", "Name", figureName);
if isempty(hFig)
  figure("name", figureName, "NumberTitle", "off", "Position", ...
      [screenSize(3)-width, screenSize(4)-height, width, height]);
end

tiledlayout("vertical")
nexttile
stem(out.in1.t,out.in1.y);
grid("on");
xlim([0, tEnd])
title("in_1");
xlabel("t")

nexttile
stem(out.in2.t,out.in2.y);
grid("on");
xlim([0, tEnd])
title("in_2");
xlabel("t")

nexttile
stem(out.out1.t,out.out1.y);
grid("on");
xlim([0, tEnd])
title("out_1");
xlabel("t")
end
