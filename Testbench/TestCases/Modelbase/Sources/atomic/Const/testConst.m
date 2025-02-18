function [out] = testConst(showPlot)
	if nargin == 0
      showPlot = false;
    end

  	global simout
  	global simin
  	global epsilon
  	global DEBUGLEVEL
  	global mu
  	mu = 0.000;
  	simout = [];
  	DEBUGLEVEL = 0;
  	epsilon = 1e-6;
	
  	
  	tend = 10; 
	
  	N1 = coordinator('N1');
  	Const = devs(am_const("c", 1.5, 1, [0, 1], 0));
  	ToWorkspace = devs(am_toworkspace('sink','out',0, "vector", [0, 100], 0));
	
  	N1.add_model(Const);
  	N1.add_model(ToWorkspace);
	
  	N1.add_coupling('c','out','sink','in');
	
  	root = rootcoordinator('root',0,tend,N1,0,0);
	
  	root.sim();
  	out = simout;
	
  	if showPlot
      	figure()
      	stem(simout.out.t,simout.out.y); grid on;
      	xlim([0 tend]);
      	xlabel('simulation time');
      	ylabel('out');
      	title('const');
  	end
  
 
end
