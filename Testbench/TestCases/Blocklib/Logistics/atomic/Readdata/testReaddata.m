function out = testReaddata(showPlot)
  if nargin == 0
    showPlot = false;
  end
   
  tEnd = 7;
    
	load_system("Readdata_Model");
	model_generator("Readdata_Model");
	out = model_simulator("Readdata_Model", tEnd);

  if showPlot
    figure("name", "testReaddata", "NumberTitle", "off")
    subplot(3,1,1)
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("time");
    ylabel("id");
    title("Generator");

    subplot(3,1,2)
    stem(out.dataOut.t,[out.dataOut.y.age]); grid on;
    xlim([0 tEnd]);
    ylim([35 45]);
    xlabel("time");
    ylabel("age");
    title("Age from entity");

    subplot(3,1,3)
    stem(out.valOut.t,out.valOut.y); grid on;
    xlim([0 tEnd]);
    ylim([35 45]);
    xlabel("time");
    ylabel("age");
    title("Age as value");
  end
end