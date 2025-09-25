function runTut04a
% makes and runs the model and plots the results
model = "tut04a";
tEnd = 15;
seed = 16;

model_generator(model); 
out = model_simulator(model, tEnd, "seed", seed);
plotResults(out, tEnd)
end

%----------------------------------------------------------------------
function plotResults(out, tEnd)
width = 700;
height = 550;
screenSize = get(0, "ScreenSize");
figureName = "tut04a";

% open new figure only if necessary
hFig = findobj("Type", "figure", "Name", figureName);
if isempty(hFig)
  figure("name", figureName, "NumberTitle", "off", "Position", ...
      [screenSize(3)-width, screenSize(4)-height, width, height]);
end

t = tiledlayout(3,2);
t.TileSpacing = "compact";
t.Padding = "compact";

nexttile(1)
stem(out.gen.t, [out.gen.y.id]);
grid("on");
xlim([0, tEnd])
title("Generator out");
xlabel("t")

nexttile(3)
stem(out.srvIn.t, [out.srvIn.y.id]);
grid("on");
xlim([0, tEnd])
title("Queue out");
xlabel("t")

nexttile(5)
stem(out.srvOut.t, [out.srvOut.y.id]);
grid("on");
xlim([0, tEnd])
title("Server out");
xlabel("t")

nexttile(2)
stairs(out.qLen.t, out.qLen.y);
grid("on");
xlim([0, tEnd])
title("Queue length");
xlabel("t")

nexttile(4)
stairs(out.sUtil.t, out.sUtil.y);
grid("on");
xlim([0, tEnd])
title("Server utilization");
xlabel("t")

nexttile(6)
stem(out.eTime.t, out.eTime.y);
grid("on");
xlim([0, tEnd])
title("Entity throughput time");
xlabel("t")
end
