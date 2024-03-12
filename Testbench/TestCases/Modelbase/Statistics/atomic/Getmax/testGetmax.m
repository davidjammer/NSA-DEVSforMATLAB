function [out] = testGetmax(showPlot)
	if nargin == 0
      showPlot = false;
    end
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
  	simin.in.t = [0,  1, 2,  3, 4, 5];
  	simin.in.y = [2,  1, 10, 7, 3, 11];
  	
	
  	N1 = coordinator('N1');
  	FromWorkspace = devs(am_fromworkspace("gen", "in", [0,1], 0));
  	Getmax = devs(am_getmax("max", [0, 1], 0));
  	Genout = devs(am_toworkspace('genout','genout',0, "vector", [0, 100], 0));
  	Maxout = devs(am_toworkspace('maxout','maxout',0, "vector", [0, 100], 0));
	
  	N1.add_model(FromWorkspace);
  	N1.add_model(Getmax);
  	N1.add_model(Genout);
  	N1.add_model(Maxout);
	
  	N1.add_coupling('gen','out','max','in');   
  	N1.add_coupling('gen','out','genout','in');
  	N1.add_coupling('max','out','maxout','in');
	
  	root = rootcoordinator('root',0,tend,N1,0,0);
	
  	root.sim();
  	out = simout;
	
  	if showPlot
      	figure()
      	subplot(2,1,1)
      	stem(simout.genout.t,simout.genout.y); grid on;
      	xlim([0 tend]);
      	xlabel('simulation time');
      	ylabel('out');
      	title('input');
	
      	subplot(2,1,2)
      	stem(simout.maxout.t,simout.maxout.y); grid on;
      	xlim([0 tend]);
      	xlabel('simulation time');
      	ylabel('out');
      	title('max');
  	end
  
 
end
