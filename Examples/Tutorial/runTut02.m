function runTut02
% makes and runs the model and plots the results
model = "tut02";
tEnd = 15;

model_generator(model); 
out = model_simulator(model, tEnd);
plotResults(out, tEnd)
end

%----------------------------------------------------------------------
function plotResults(out, tEnd)
width = 450;
height = 600;
screenSize = get(0, "ScreenSize");
figureName = "tut02";

% open new figure only if necessary
hFig = findobj("Type", "figure", "Name", figureName);
if isempty(hFig)
  figure("name", figureName, "NumberTitle", "off", "Position", ...
      [screenSize(3)-width, screenSize(4)-height, width, height]);
end

tiledlayout("vertical")
nexttile
stem(out.gen.t,out.gen.y);
grid("on");
xlim([0, tEnd])
title("Generator out");
xlabel("t")

nexttile
stem(out.srvIn.t,out.srvIn.y);
grid("on");
xlim([0, tEnd])
title("Queue out");
xlabel("t")

nexttile
stem(out.srvOut.t,out.srvOut.y);
grid("on");
xlim([0, tEnd])
title("Server out");
xlabel("t")
end
