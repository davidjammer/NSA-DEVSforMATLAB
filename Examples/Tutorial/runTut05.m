function runTut05
% makes and runs the model and plots the results
model = "tut05";
tEnd = 6;

model_generator(model); 
out = model_simulator(model, tEnd);
plotResults(out, tEnd)
end

%----------------------------------------------------------------------
function plotResults(out, tEnd)
width = 450;
height = 600;
screenSize = get(0, "ScreenSize");
figureName = "tut05";

% open new figure only if necessary
hFig = findobj("Type", "figure", "Name", figureName);
if isempty(hFig)
  figure("name", figureName, "NumberTitle", "off", "Position", ...
      [screenSize(3)-width, screenSize(4)-height, width, height]);
end

tiledlayout("vertical")
nexttile
stem(out.in1.t, out.in1.y);
grid("on");
xlim([0, tEnd])
title("in_1");
xlabel("t")

nexttile
stem(out.in2.t, out.in2.y);
grid("on");
xlim([0, tEnd])
title("in_2");
xlabel("t")

nexttile
stem(out.out1.t, out.out1.y);
grid("on");
xlim([0, tEnd])
title("out_1");
xlabel("t")
end
