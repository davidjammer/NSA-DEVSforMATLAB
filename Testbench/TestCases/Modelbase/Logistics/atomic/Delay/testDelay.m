function out = testDelay()
  global simout
  simout = [];

 
  tEnd = 21;
 

  tVec = [1, 3, 7, 8, 9];
  yVec = [2, -3, 2, -2, -1];
  g = [2,0];

  mdebug = false;
  rOut = 3.0;

  N1 = coordinator("N1");

  Vectorgen = devs(am_vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
  Delay = devs(am_delay("Delay", g, [0, 1], mdebug));
  Terminator1 = devs(am_terminator("Terminator1", [0, rOut], mdebug));
  Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", [0, rOut], mdebug));
  Delayout = devs(am_toworkspace("Delayout", "DelayOut", 0, "vector", [0, rOut], mdebug));

  N1.add_model(Vectorgen);
  N1.add_model(Delay);
  N1.add_model(Terminator1);
  N1.add_model(Delayout);
  N1.add_model(Genout);

  N1.add_coupling("Vectorgen","out","Delay","in");
  N1.add_coupling("Delay","out","Terminator1","in");
  N1.add_coupling("Vectorgen","out","Genout","in");
  N1.add_coupling("Delay","out","Delayout","in");

  root = rootcoordinator("root",0,tEnd,N1,0,0);
  root.sim();
  out = simout;

  if 0
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

end
