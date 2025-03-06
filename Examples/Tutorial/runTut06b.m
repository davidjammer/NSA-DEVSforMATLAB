function runTut06b
% makes and runs the model and plots the results
model = "tut06b";
tEnd = 13;
rng(3);

model_generator(model); 
out = model_simulator(model, tEnd, true, false);
plotResults(out, tEnd)
end

%----------------------------------------------------------------------
function plotResults(out, tEnd)
width = 700;
height = 550;
screenSize = get(0, "ScreenSize");
figureName = "tut06b";

% open new figure only if necessary
hFig = findobj("Type", "figure", "Name", figureName);
if isempty(hFig)
  figure("name", figureName, "NumberTitle", "off", "Position", ...
      [screenSize(3)-width, screenSize(4)-height, width, height]);
end

t = tiledlayout(2,2);
t.TileSpacing = "compact";
t.Padding = "compact";

nexttile()
stem(out.gen.t, out.gen.y);
grid("on");
xlim([0, tEnd])
title("Generator out");
xlabel("t")

nexttile()
stem(out.qIn.t, [out.qIn.y.id]);
grid("on");
xlim([0, tEnd])
title("Queue in");
xlabel("t")

nexttile()
stem(out.qOut.t, [out.qOut.y.id]);
grid("on");
xlim([0, tEnd])
title("Queue out");
xlabel("t")

nexttile()
stem(out.sysOut.t, [out.sysOut.y.id]);
grid("on");
xlim([0, tEnd])
title("System out");
xlabel("t")

end
