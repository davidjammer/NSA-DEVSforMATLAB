function [out]=testBias(showPlot)
  if nargin == 0
    showPlot = false;
  end

  global simout
  global epsilon
  global DEBUGLEVEL
  global mi
  mi = 0.0;
  simout = [];
  DEBUGLEVEL = 0;           % simulator debug level
  epsilon = 1e-6;

  tVec = [1, 3, 7, 8, 9];
  yVec = [2, -3, 2, -2, -1];
  bias = 2;
  tEnd = 17;
  mdebug = false;
  rOut = 3.0;

  N1 = coordinator("N1");

  Vectorgen = devs(am_vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
  Bias = devs(am_bias("Bias", bias, [0, 1],mdebug));
  Terminator1 = devs(am_terminator("Terminator", [0, rOut], mdebug));
  Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", [0, rOut], mdebug));
  Biasout = devs(am_toworkspace("Biasout", "gainOut", 0, "vector", [0, rOut], mdebug));

  N1.add_model(Vectorgen);
  N1.add_model(Bias);
  N1.add_model(Terminator1);
  N1.add_model(Genout);
  N1.add_model(Biasout);

  N1.add_coupling("Vectorgen","out","Bias","in");
  N1.add_coupling("Bias","out","Terminator1","in");
  N1.add_coupling("Vectorgen","out","Genout","in");
  N1.add_coupling("Bias","out","Biasout","in");

  root = rootcoordinator("root",0,tEnd,N1,0,0);
  root.sim();

  out = simout;

  if showPlot
    figure("Position",[1 1 450 500]);
    subplot(2,1,1)
    stairs(simout.genOut.t,simout.genOut.y);
    hold("on");plot(simout.genOut.t,simout.genOut.y, "*");hold("off");
    grid("on");
    xlim([0, tEnd])
    ylim([-3.2, 2.2])
    xlabel("simulation time");
    ylabel("out");
    title("VectorGen");

    subplot(2,1,2)
    stairs(simout.gainOut.t,simout.gainOut.y);
    hold("on");plot(simout.gainOut.t,simout.gainOut.y, "*");hold("off");
    grid("on");
    xlim([0, tEnd])
    ylim([-1.4, 4.4])
    xlabel("simulation time");
    ylabel("out");
    title("Bias");
  end

end