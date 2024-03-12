function runShiftregister1
% makes and runs model and plots results
% optional: 
%   set global DEBUGLEVEL
%   model_simulator(model, tEnd, false)
model = "shiftregister1";

tEnd = 13;

model_generator(model); 
out = model_simulator(model, tEnd);
plotResults(out, tEnd)
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
figure("name","shiftregister1","NumberTitle","off", ...
       "Position",[1 1 550 775]);
subplot(6,1,1)
plot_ieee1164(out.bin1Out.t,out.bin1Out.y,["0","1"]);
title("In");
xlim([0, tEnd])

subplot(6,1,2)
plot_ieee1164(out.bin2Out.t,out.bin2Out.y,["0","1"]);
title("CLK");
xlim([0, tEnd])

subplot(6,1,3)
plot_ieee1164(out.q1Out.t,out.q1Out.y,["0","1"]);
title("Out 1");
xlim([0, tEnd])

subplot(6,1,4)
plot_ieee1164(out.q2Out.t,out.q2Out.y,["U","0","1"]);
title("Out 2");
xlim([0, tEnd])

subplot(6,1,5)
plot_ieee1164(out.q3Out.t,out.q3Out.y,["U","0","1"]);
title("Out 3");
xlim([0, tEnd])

subplot(6,1,6)
plot_ieee1164(out.q4Out.t,out.q4Out.y,["U","0","1"]);
title("Out 4");
xlim([0, tEnd])
end
