function plotStatBench(qAll, allXacts, qWaitData, type, extraXacts, nP)
  % creates statistic plots and outputs for the benchmark
  % type and extraXacts for special outputs
  %   type = 1 -> standard, extraXacts = empty
  %   type = 2 -> reneging, extraXacts = reneging infos
  %   type = 3 -> classing, extraXacts = operator infos
  %   type = 4 -> jockeying, extraXacts = jockeying infos

  if nargin < 4
    type = 1;
    extraXacts = [];
  end
  if nargin < 6
    nP = 20;        % number of outgoing entities shown
  end
  
  % prepare data
  tStart = allXacts(end-nP+1,1);
  tEnd = allXacts(end,1);
  % qLens = deleteEqualTimes(qLens);
  % nServer = length(qLens);
  % for I=1:nServer
  %   % add value at tEnd, if necessary
  %   if qLens{I}(end,1) < tEnd
  %     qLens{I} = [qLens{I}; [tEnd 0]];
  %   end
  % end
  % qAll = combineQueueLengths(qLens);
  qWait = qWaitData(:,2);
  
  % compute statistical data
  tq = qAll(:,1);
  areaA = diff(tq).*qAll(1:end-1, 2);
  InqA = cumsum(areaA);
  nqMeanA = [0;InqA./tq(2:end)];
  fprintf('\navg. qDelay: %6.3f\n', mean(qWait))
  fprintf('max. qDelay: %6.3f\n', max(qWait))
  fprintf('avg. qLen:   %6.3f\n', nqMeanA(end))
  fprintf('max. qLen:   %6.3f\n', max(qAll(:,2)))
   
  switch type
    case 2                   % reneging
      printReneging(extraXacts);
    case 3                   % classing
      printClassWaits(allXacts(:,3), qWait);
    case 4                   % jockeying
      printJockeying(extraXacts);
  end
    
  % Plots
  figure("name", "fifo4", "NumberTitle","off", ...
         "Position",[1 1 600 250], "Color", [1 1 1]);
  
  subplot1 = subplot(1,2,1);
  tPlot = allXacts(end-nP+1:end,1);
  idPlot = allXacts(end-nP+1:end,2);
  stem(tPlot, idPlot, 'k')
  if type == 2 && ~isempty(extraXacts)
    hold('on')
    stem(extraXacts(:,1), extraXacts(:,2), 'b-.')
    hold('off')
  end
  xlim([tStart-1, tEnd+1])
  ylim([min(idPlot)-1, max(idPlot)+1])
  set(subplot1,'Color',[1 1 1],'XColor',[0 0 0],'YColor',[0 0 0])
  title('outgoing entities', 'Color', 'k')
  ylabel('ids', 'FontSize', 13)
  
  subplot2 = subplot(1,2,2);
  stairs(qAll(:,1), qAll(:,2), 'k')
  xlim([0, tEnd+1])
  set(subplot2,'Color',[1 1 1],'XColor',[0 0 0],'YColor',[0 0 0])
  title('total queue length', 'Color', 'k')  
  ylabel('l_{qt}', 'FontSize', 13)
end

%----------------------------------------------------------------------
function qLens = deleteEqualTimes(qLens)
  % iterates through cell array qLens and
  % keeps from several rows with equal time only the last one
  for I = 1:length(qLens)
    [~, ia] = unique(qLens{I}(:,1), 'last');
    qLens{I} = qLens{I}(ia,:);
  end
end

function qAll = combineQueueLengths(qLens)
  % computes total queue lengths from three queues
  all = cell2mat(qLens');
  tAll = unique(sort(all(:,1)));       % combine all times
  qAll = [tAll, ...
       interp1(qLens{1}(:,1), qLens{1}(:,2), tAll, 'previous', 'extrap')];
  for I=2:length(qLens)
    qAll(:,2) = qAll(:,2) ...
       + interp1(qLens{I}(:,1), qLens{I}(:,2), tAll, 'previous', 'extrap');
  end
end

function printClassWaits(classes, qWait)
  % print queue waiting statistics per class
  nClass = max(classes);
  classWaitsMax = zeros(nClass,1);
  classWaitsMean = zeros(nClass,1);
  for I=1:nClass
    cWaits = qWait(classes == I);
    classWaitsMax(I) = max(cWaits);
    classWaitsMean(I) = mean(cWaits);
  end
  fprintf('\nqueue waits per class\n class')
  fprintf(' %6d', 1:nClass)
  fprintf('\n avg.   ')
  fprintf(' %6.2f', classWaitsMean)
  fprintf('\n max    ')
  fprintf(' %6.2f', classWaitsMax)
  fprintf('\n')
end

function printJockeying(extraXacts)
  % print jockeying events
  fprintf('Jockeying:\n')
  fprintf('total no.: %3d\n', size(extraXacts,1))
  fprintf('  t     id     src   dest\n')
  fprintf('-------------------------\n')
  for I=1:size(extraXacts,1)
    fprintf('%5.1f  %3d     %2d     %2d\n', extraXacts(I,:))
  end
end

function printReneging(extraXacts)
  % print reneging events
  fprintf('Reneging:\n')
  fprintf('total no.: %3d\n', size(extraXacts,1))
  fprintf('  t     id\n')
  fprintf('------------\n')
  for I=1:size(extraXacts,1)
    fprintf('%5.1f  %3d\n', extraXacts(I,:))
  end
end
