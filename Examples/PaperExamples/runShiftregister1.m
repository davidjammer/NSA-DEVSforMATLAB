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
       "Position",[1 1 550 575]);
subplot(6,1,1)
stairs(out.bin1Out.t,out.bin1Out.y);
title("In");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,2)
stairs(out.bin2Out.t,out.bin2Out.y);
title("CLK");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,3)
stairs(out.q1Out.t,out.q1Out.y);
title("Out 1");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,4)
stairs(out.q2Out.t,out.q2Out.y);
title("Out 2");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,5)
stairs(out.q3Out.t,out.q3Out.y);
title("Out 3");
xlim([0, tEnd])
ylim([-0.1, 1.1])

subplot(6,1,6)
stairs(out.q4Out.t,out.q4Out.y);
title("Out 4");
xlim([0, tEnd])
ylim([-0.1, 1.1])
end
