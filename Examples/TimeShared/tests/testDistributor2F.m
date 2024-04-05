function out = testDistributor2F(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 10;
  rng(28);     % set seed for random generator

	load_system("Distributor2F_Model");
	model_generator("Distributor2F_Model");
	out = model_simulator("Distributor2F_Model", tEnd);

  if showPlot
    figure("name", "testDistributor2F", "NumberTitle", "off")
    subplot(2,2,1)
    stem(out.dataIn.t,[out.dataIn.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Input Data");

    subplot(2,2,2)
    stem(out.dataIn.t,[out.dataIn.y.port]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("port");
    title("Input Data");
    
    subplot(2,2,3)
    stem(out.dataOut1.t,[out.dataOut1.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Output 1");

    subplot(2,2,4)
    stem(out.dataOut2.t,[out.dataOut2.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Output 2");
  end
end