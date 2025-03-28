function [out]= testCollect3(showPlot)
  if nargin == 0
    showPlot = false;
  end

  global simout
  global epsilon
  global DEBUGLEVEL
  global mu
  mu = 0.000;
  simout = [];
  DEBUGLEVEL = 0;           % simulator debug level
  epsilon = 1e-6;

  tend = 15;


  nG = 100;
  tG1 = 1;
  tG2 = 2;
  tG3 = 3;
  mdebug = false;
  rOut = 1.0;

  N1 = coordinator("N1");

  Generator1 = devs(am_generator("Generator1", tG1, 1, nG, [0, 1], mdebug));
  Generator2 = devs(am_generator("Generator2", tG2, 21, nG, [0, 1], mdebug));
  Generator3 = devs(am_generator("Generator3", tG3, 41, nG, [0, 1], mdebug));
  Collect3 = devs(am_collect3("Collect3", [0, 10], [0, 10], mdebug));
  Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
  Gen1out = devs(am_toworkspace("Gen1out", "gen1Out", 0, "vector", [0, rOut], mdebug));
  Gen2out = devs(am_toworkspace("Gen2out", "gen2Out", 0, "vector", [0, rOut], mdebug));
  Gen3out = devs(am_toworkspace("Gen3out", "gen3Out", 0, "vector", [0, rOut], mdebug));
  Combout = devs(am_toworkspace("Combout", "combOut", 0, "vector", [0, rOut], mdebug));

  N1.add_model(Generator1);
  N1.add_model(Generator2);
  N1.add_model(Generator3);
  N1.add_model(Collect3);
  N1.add_model(Terminator1);
  N1.add_model(Gen1out);
  N1.add_model(Gen2out);
  N1.add_model(Gen3out);
  N1.add_model(Combout);

  N1.add_coupling("Generator1","out","Collect3","in1");
  N1.add_coupling("Generator2","out","Collect3","in2");
  N1.add_coupling("Generator3","out","Collect3","in3");
  N1.add_coupling("Collect3","out","Terminator1","in");
  N1.add_coupling("Generator1","out","Gen1out","in");
  N1.add_coupling("Generator2","out","Gen2out","in");
  N1.add_coupling("Generator3","out","Gen3out","in");
  N1.add_coupling("Collect3","out","Combout","in");

  root = rootcoordinator("root",0,tend,N1,0,0);
  root.sim();

  if showPlot
    figure("name", "testCollect3", "NumberTitle", "off", ...
      "Position", [1 1 450 500]);
    subplot(4,1,1)
    stem(simout.gen1Out.t,simout.gen1Out.y);
    title("Generator 1");
    xlim([0,16])

    subplot(4,1,2)
    stem(simout.gen2Out.t,simout.gen2Out.y);
    title("Generator 2");
    xlim([0,16])

    subplot(4,1,3)
    stem(simout.gen3Out.t,simout.gen3Out.y);
    title("Generator 3");
    xlim([0,16])

    subplot(4,1,4)
    stem(simout.combOut.t,simout.combOut.y);
    title("Collect3");
    xlim([0,16])
  end

  out = simout;
end
