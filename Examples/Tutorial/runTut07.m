function runTut07
% makes and runs the model and plots the results
model = "tut07";
tEnd = 500;

model_generator(model); 
out = model_simulator(model, tEnd, "seed", 6);
plotResults(out, tEnd)
end

%----------------------------------------------------------------------
function plotResults(out, tEnd)
width = 700;
height = 300;
screenSize = get(0, "ScreenSize");
figureName = "tut07";

tMin = 340;
tMax = 380;

% open new figure only if necessary
hFig = findobj("Type", "figure", "Name", figureName);
if isempty(hFig)
  figure("name", figureName, "NumberTitle", "off", "Position", ...
      [screenSize(3)-width, screenSize(4)-height, width, height]);
end

t = tiledlayout(2,3);
t.TileSpacing = "compact";
t.Padding = "compact";

nexttile(1)
stem(out.gen.t, out.gen.y);
grid("on");
xlim([0, tEnd])
title("Generator out");
xlabel("t")

nexttile(4)
idxLo = find(out.gen.t < tMin, 1, "last");
idxHi = find(out.gen.t > tMax, 1);
idx = idxLo:idxHi;
stem(out.gen.t(idx), out.gen.y(idx));
grid("on");
title("Generator out");
xlabel("t")

nexttile(2)
stairs(out.isFull.t, out.isFull.y);
grid("on");
xlim([0, tEnd])
title("Queue isFull");
xlabel("t")
ylim([-0.1, 1.1])

nexttile(5)
idxLo = find(out.isFull.t < tMin, 1, "last");
idxHi = find(out.isFull.t > tMax, 1);
idx = idxLo:idxHi;
stairs(out.isFull.t(idx), out.isFull.y(idx));
grid("on");
title("Queue isFull");
xlabel("t")
ylim([-0.1, 1.1])

nexttile(6)
stem(out.srvOut.t, out.srvOut.y);
grid("on");
xlim([0, tEnd])
title("Server out");
xlabel("t")

nexttile(3)
stairs(out.qLen.t, out.qLen.y);
grid("on");
xlim([0, tEnd])
title("Queue length");
xlabel("t")
end
