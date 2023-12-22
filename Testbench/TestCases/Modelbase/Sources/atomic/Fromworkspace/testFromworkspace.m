function [out] = testFromworkspace()
  global simout
  global simin
  global epsilon
  global DEBUGLEVEL
  global mi
  mi = 0.000;
  simout = [];
  DEBUGLEVEL = 0;
  epsilon = 1e-6;

  
  tend = 10;
  simin.in.t = [0,  1, 2, 3, 4, 5];
  simin.in.y = [10,11,12,13,14,15];
  

  N1 = coordinator('N1');
  FromWorkspace = devs(am_fromworkspace("gen", "in", [0,1], 0));
  ToWorkspace = devs(am_toworkspace('sink','out',0, "vector", [0, 100], 0));

  N1.add_model(FromWorkspace);
  N1.add_model(ToWorkspace);

  N1.add_coupling('gen','out','sink','in');

  root = rootcoordinator('root',0,tend,N1,0,0);

  root.sim();
  out = simout;

  if 0
      figure()
      stem(simout.out.t,simout.out.y); grid on;
      xlim([0 tend]);
      xlabel('simulation time');
      ylabel('out');
      title('fromworkspace');
  end
  
 
end
