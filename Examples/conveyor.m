function out = conveyor(tEnd)
  global simout
  simout = [];

  if nargin ~= 1
    tEnd = 25;
  end

  tVec = [0,1, 5, 7, 8, 10];
  yVec = [0,2, 2, 2, 2, 2];
  g = 2;

  mdebug = false;
  rOut = 3.0;

  N1 = coordinator("N1");

  Vectorgen = devs(vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
  Delay = devs(delay("Delay", g, [0, 1], mdebug));
  HInt = devs(hIntegrator("hInt", 0.01, 0.01, 0, [0, 1], mdebug));
  Terminator1 = devs(terminator1("Terminator1", "tOut", 0, [0, rOut]));
  Genout = devs(toworkspace("Genout", "genOut", 0, "vector", [0, rOut], 0));
  Latout = devs(toworkspace("Latout", "latOut", 0, "vector", [0, rOut], 0));
  Hintout = devs(toworkspace("hintout", "hintOut", 0, "vector", [0, rOut], 0));

  N1.add_model(Vectorgen);
  N1.add_model(Delay);
  N1.add_model(HInt);
  N1.add_model(Terminator1);
  N1.add_model(Genout);
  N1.add_model(Latout);
  N1.add_model(Hintout);

  N1.add_coupling("Vectorgen","out","Delay","in");
  N1.add_coupling("Delay","out","hInt","in");
  N1.add_coupling("hInt","out","Terminator","in");
  N1.add_coupling("Vectorgen","out","Genout","in");
  N1.add_coupling("Delay","out","Latout","in");
  N1.add_coupling("hInt","out","hintout","in");

  root = rootcoordinator("root",0,tEnd,N1,0,0);
  root.sim();
  out = simout;

  figure("Position",[1 1 450 500]);
  subplot(3,1,1)
  stairs(simout.genOut.t,simout.genOut.y);
  hold("on");plot(simout.genOut.t,simout.genOut.y, "*");hold("off");
  grid("on");
  xlim([0, tEnd])
  ylim([-0.2, 2.2])
  xlabel("simulation time");
  ylabel("out");
  title("mdot");

  subplot(3,1,2)
  stairs(simout.latOut.t,simout.latOut.y);
  hold("on");plot(simout.latOut.t,simout.latOut.y, "*");hold("off");
  grid("on");
  xlabel("simulation time");
  ylabel("out");
  xlim([0, tEnd])
  ylim([-0.2, 2.2])
  title("mdot delayed");

  subplot(3,1,3)
  stairs(simout.hintOut.t,simout.hintOut.y);
  grid("on");
  xlim([0, tEnd])
  xlabel("simulation time");
  ylabel("out");
  title("m(t)");
end
