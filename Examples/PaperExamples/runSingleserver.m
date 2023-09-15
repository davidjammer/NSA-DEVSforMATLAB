function runSingleserver
% makes and runs model and plots results
% optional: 
%   set global DEBUGLEVEL
%   model_simulator(model, tEnd, false)
model = "singleserver";

tEnd = 10;

model_generator(model); 
out = model_simulator(model, tEnd);
plotResults(out, tEnd)
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
figure("name","singleserver","NumberTitle","off", "Position",[1 1 550 350]);
subplot(2,2,1)
stem(out.genOut.t,out.genOut.y);
grid("on");
xlim([0 tEnd]);
ylim([0, tEnd])
ylabel("out");
xlabel("t");
title("Generator");

subplot(2,2,2)
stem(out.queOut.t,out.queOut.y);
grid("on");
xlim([0 tEnd]);
ylim([0, 10])
ylabel("out");
xlabel("t");
title("Queue");

subplot(2,2,3)
stairs(out.quenOut.t,out.quenOut.y);
%hold("on");plot(simout.quenOut.t,simout.quenOut.y, "*");hold("off");
grid("on");
xlim([0 tEnd]);
ylim([0, 4])
ylabel("nq");
xlabel("t");
title("Queue");

subplot(2,2,4)
stem(out.srvOut.t,out.srvOut.y);
grid("on");
xlim([0 tEnd]);
ylim([0, 10])
ylabel("out");
xlabel("t");
title("Server");
end
