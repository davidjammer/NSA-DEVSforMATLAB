function out = testDelay(tEnd)
  global simout
  simout = [];

  if nargin ~= 1
    tEnd = 21;
  end

  tVec = [1, 3, 7, 8, 9];
  yVec = [2, -3, 2, -2, -1];
  g = [2,0];

  mdebug = false;
  rOut = 3.0;

  N1 = coordinator("N1");

  Vectorgen = devs(vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
  Delay = devs(delay("Delay", g, [0, 1], mdebug));
  Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
  Genout = devs(toworkspace("Genout", "genOut", 0, "vector", [0, rOut], 0));
  Delayout = devs(toworkspace("Delayout", "DelayOut", 0, "vector", [0, rOut], 0));

  N1.add_model(Vectorgen);
  N1.add_model(Delay);
  N1.add_model(Terminator1);
  N1.add_model(Delayout);
  N1.add_model(Genout);

  N1.add_coupling("Vectorgen","out","Delay","in");
  N1.add_coupling("Delay","out","Terminator1","in");
  N1.add_coupling("Vectorgen","out","Genout","in");
  N1.add_coupling("Delay","out","Delayout","in");

  root = rootcoordinator("root",0,tEnd,N1,0,mdebug);
  root.sim();
  out = simout;

  figure("Position",[1 1 450 500]);
  subplot(2,1,1)
  stairs(simout.genOut.t,simout.genOut.y);
  hold("on"); plot(simout.genOut.t,simout.genOut.y, "*"); hold("off");
  grid("on");
  xlim([0, tEnd])
  ylim([-3.2, 2.2])
  xlabel("simulation time");
  ylabel("out");
  title("Delay in");

  subplot(2,1,2)
  stairs(simout.DelayOut.t,simout.DelayOut.y);
  hold("on"); plot(simout.DelayOut.t,simout.DelayOut.y, "*"); hold("off");
  grid("on");
  xlim([0, tEnd])
  ylim([-3.2, 2.2])
  xlabel("simulation time");
  ylabel("out");
  title("Delay out");

end
