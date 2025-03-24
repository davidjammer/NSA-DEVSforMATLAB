function out = testWritedata(showPlot)
  if nargin == 0
    showPlot = false;
  end
   
  tEnd = 11;
  rng(3);     % set seed for random generator

	load_system("Writedata_Model");
	model_generator("Writedata_Model");
	out = model_simulator("Writedata_Model", tEnd);

  if showPlot
    figure("name", "testWritedata", "NumberTitle", "off")
    subplot(3,1,1)
    stem(out.data3Out.t,[out.data3Out.y.height]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("m");
    title("Height");

    subplot(3,1,2)
    stem(out.data3Out.t,[out.data3Out.y.weight]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("kg");
    title("Weight");

    subplot(3,1,3)
    stem(out.data3Out.t,[out.data3Out.y.bmi]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("kg/m^2");
    title("BMI");
  end
end