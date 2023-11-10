function runTestGrinding()
  % makes and runs model and plots results
  %   set global DEBUGLEVEL
  %   model_simulator(model, tEnd, false)

  model = "testGrinding";
 
  tEnd = 20000;

  model_generator(model);
  out = model_simulator(model, tEnd);
  plotResults(out, tEnd, model)
  
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd, model)
  figure("name", model, "NumberTitle", "off",...
         "Position", [1 1 650 650]);
  subplot(3,2,1)
  stairs(out.o1.t, out.o1.y)
  xlim([0 tEnd]);
  title("Input");

  subplot(3,2,2)
  stem(out.o2.t, out.o2.y)
  xlim([0 tEnd]);
  title("Working");

  subplot(3,2,3)
  stairs(out.o3.t, out.o3.y)
  xlim([0 tEnd]);
  title("Queue length");

  subplot(3,2,4)
  stairs(out.o4.t, out.o4.y)
  xlim([0 tEnd]);
  title("Energy");

  subplot(3,2,5)
  stairs(out.o5.t, out.o5.y)
  xlim([0 tEnd]);
  title("id out");

  subplot(3,2,6)
  stairs(out.o6.t, out.o6.y)
  xlim([0 tEnd]);
  title("n out");

end
