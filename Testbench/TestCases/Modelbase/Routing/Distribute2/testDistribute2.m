function [out] = testDistribute2(showPlot)
  if nargin == 0
    showPlot = false;
  end

  global simout
  global epsilon
  global DEBUGLEVEL
  global mu
  mu = 0.0;
  simout = [];
  DEBUGLEVEL = 0;           % simulator debug level
  epsilon = 1e-6;

  tend = 15;

  nG = 100;
  tG = 1;
  tVec = [1.5 2.5 4.5 6.5];
  yVec = [2, 1, 1, 2];
  tend = 15;
  mdebug = false;
  rOut = 3.0;

  N1 = coordinator("N1");

  Generator1 = devs(am_generator("Generator1", tG, 1, nG, [0, 1], mdebug));
  Vectorgen = devs(am_vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
  Distribute2 = devs(am_distribute2("Distribute2", 1, "", [0, 1], mdebug));
  Terminator1 = devs(am_terminator("Terminator1", [0, 1], mdebug));
  Terminator2 = devs(am_terminator("Terminator2", [0, 1], mdebug));
  Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", [0, rOut], 0));
  VGenout = devs(am_toworkspace("VGenout", "vgenOut", 0, "vector", [0, rOut], 0));
  Distout1 = devs(am_toworkspace("Distout1", "dist1Out", 0, "vector", [0, rOut], 0));
  Distout2 = devs(am_toworkspace("Distout2", "dist2Out", 0, "vector", [0, rOut], 0));

  N1.add_model(Generator1);
  N1.add_model(Vectorgen);
  N1.add_model(Distribute2);
  N1.add_model(Terminator1);
  N1.add_model(Terminator2);
  N1.add_model(Genout);
  N1.add_model(VGenout);
  N1.add_model(Distout1);
  N1.add_model(Distout2);

  N1.add_coupling("Generator1","out","Distribute2","in");
  N1.add_coupling("Vectorgen","out","Distribute2","port");
  N1.add_coupling("Distribute2","out1","Terminator1","in");
  N1.add_coupling("Distribute2","out2","Terminator2","in");
  N1.add_coupling("Generator1","out","Genout","in");
  N1.add_coupling("Vectorgen","out","VGenout","in");
  N1.add_coupling("Distribute2","out1","Distout1","in");
  N1.add_coupling("Distribute2","out2","Distout2","in");

  root = rootcoordinator("root",0,tend,N1,0,0);
  root.sim();
  out = simout;

  if showPlot
    figure("name", "testDistribute2", "NumberTitle", "off", ...
      "Position",[1 1 550 575]);
    subplot(2,2,1)
    stem(simout.genOut.t,simout.genOut.y);
    grid("on");
    xlim([0, tend])
    ylabel("out");
    title("Generator");

    subplot(2,2,3)
    stairs(simout.vgenOut.t,simout.vgenOut.y);
    hold("on");plot(simout.vgenOut.t,simout.vgenOut.y, "*");hold("off");
    grid("on");
    xlim([0, tend])
    ylim([0.8, 2.2])
    ylabel("out");
    title("Distributor port");

    subplot(2,2,2)
    stem(simout.dist1Out.t,simout.dist1Out.y);
    grid("on");
    xlim([0, tend])
    ylim([0, 15])
    ylabel("out1");
    title("Distributor");

    subplot(2,2,4)
    stem(simout.dist2Out.t,simout.dist2Out.y);
    grid("on");
    xlim([0, tend])
    ylim([0, 15])
    ylabel("out2");
    title("Distributor");
  end

end
