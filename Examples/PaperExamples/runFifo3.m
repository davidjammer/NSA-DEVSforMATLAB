function runFifo3
% makes and runs model and plots results
% optional: 
%   set global DEBUGLEVEL
%   model_simulator(model, tEnd, false)
model = "fifo3";

tEnd = 25;

model_generator(model); 
out = model_simulator(model, tEnd);
plotResults(out)
end

%---------------------------------------------------------------------------
function plotResults(out)
qAll = combineQueueLengths(out.nq1,out.nq2, out.nq3);

tPlot = out.output.t';
idPlot = out.output.y';
tEnd = tPlot(end);
  
figure("name", "fifo3", "NumberTitle", "off", "Position", [1 1 600 250]);
subplot(1,2,1);
stem(tPlot, idPlot)
xlim([0, tEnd+1])
ylim([0, 15])
title('outgoing entities')
ylabel('ids')
  
subplot(1,2,2);
stairs(qAll(:,1), qAll(:,2))
xlim([0, tEnd+1])
ylim([0, 4.3])
title('total queue length')  
ylabel('l_{qt}')
end

function qSum = combineQueueLengths(nq1, nq2, nq3)
% computes total queue lengths from three queues

% keep from several rows with equal time only the last one
nq = [nq1, nq2, nq3];
for I = 1:3
  all = [nq(I).t', nq(I).y'];
  [~, ia] = unique(nq(I).t, 'last');
  lq{I} = all(ia,:);
end

% combine all times
tAll = unique(sort([lq{1}(:,1); lq{2}(:,1); lq{3}(:,1)]));  
qAll = tAll;
for I = 1:3
  qAll = [qAll, interp1(lq{I}(:,1), lq{I}(:,2), tAll, "previous", "extrap")];
end
qSum = [tAll, sum(qAll(:, 2:4), 2)];
end
