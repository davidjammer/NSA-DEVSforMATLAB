function runTestTurningMachine()
  % makes and runs model and plots results
  %   set global DEBUGLEVEL
  %   model_simulator(model, tEnd, false)

  model = "testTurningMachine";
 
  tEnd = 15000;

  model_generator(model);
  out = model_simulator(model, tEnd);
  plotResults(out, tEnd)
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
  figure("name", "testTurningMachine", "NumberTitle", "off",...
         "Position", [1 1 800 750]);
  subplot(4,2,1)
  stairs(out.nq.t, out.nq.y)
  title("Queue length");
  xlabel("t [s]");
  xlim([0 tEnd]);
  ylim([0 1.1]);

  subplot(4,2,2)
  stairs(out.E.t, out.E.y)
  title("Energy");
  ylabel("E [kWh]");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(4,2,3)
  stairs(out.P.t, out.P.y)
  title("Power");
  ylabel("P [kW]");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(4,2,4)
  stairs(out.u.t, out.u.y)
  title("Voltage");
  ylabel("U [V]");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(4,2,5)
  stairs(out.i.t, out.i.y)
  title("Current");
  ylabel("I [A]");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(4,2,6)
  stairs(out.n.t, out.n.y)
  title("Speed");
  ylabel("n [Upm]");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(4,2,7)
  cats = ["idle", "startup", "turning", "down", "wait"];
  ph = categorical(out.phase.y, cats, "Ordinal", true);
  stairs(out.phase.t, ph)
  title("Phase");
  xlabel("t [s]");
  xlim([0 tEnd]);

  subplot(4,2,8)
  stairs(out.nout.t, out.nout.y)
  title("Output");
  xlabel("t [s]");
  xlim([0 tEnd]);
  ylim([0 4.2]);
 
end
