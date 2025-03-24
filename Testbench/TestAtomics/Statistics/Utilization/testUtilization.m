function [out] = testUtilization(showPlot)
  if nargin == 0
    showPlot = false;
  end

  global simout
  global epsilon
  global DEBUGLEVEL
  global mu

  tEnd = 1000;

  simout = [];
  DEBUGLEVEL = 0;           % simulator debug level
  epsilon = 1e-6;

  mdebug = 0;
  rOut = 100;
  nG = 1000;
  tG = 6;
  tS = 1.5;
  disp(mu);
  get_mu();
  N1 = coordinator("N1");

  Generator = devs(am_generator("Generator", tG, 1, nG, [0,1], mdebug));
  Queue = devs(am_queue("Queue", [0,2], [0,2], mdebug));
  Server = devs(am_server("Server", tS, "", [0,1], mdebug));
  Terminator = devs(am_terminator("Terminator",[0,1], mdebug));
  GenOut = devs(am_toworkspace("GenOut", "genOut", 0,"vector", [0,rOut], 0));
  QueOut = devs(am_toworkspace("QueOut", "queOut", 0,"vector",[0,rOut], 0));
  SrvOut = devs(am_toworkspace("SrvOut", "srvOut", 0,"vector",[0,rOut], 0));
  SrvNOut = devs(am_toworkspace("SrvNOut", "srvnOut", 0,"vector",[0,rOut], 0));
  utilOut = devs(am_toworkspace("utilOut", "utilOut", 0,"vector",[0,rOut], 0));
  util = devs(am_utilization("util", [0,1], mdebug));

  N1.add_model(Generator);
  N1.add_model(Queue);
  N1.add_model(Server);
  N1.add_model(Terminator);
  N1.add_model(GenOut);
  N1.add_model(QueOut);
  N1.add_model(SrvNOut);
  N1.add_model(SrvOut);
  N1.add_model(util);
  N1.add_model(utilOut);

  N1.add_coupling("Generator","out","Queue","in");
  N1.add_coupling("Queue","out","Server","in");
  N1.add_coupling("Server","out","Terminator","in");
  N1.add_coupling("Server","working","Queue","bl");
  N1.add_coupling("Generator","out","GenOut","in");
  N1.add_coupling("Queue","out","QueOut","in");
  N1.add_coupling("Server","out","SrvOut","in");
  N1.add_coupling("Server","n","SrvNOut","in");
  N1.add_coupling("Server","working","util","in");
  N1.add_coupling("util","out","utilOut","in");

  root = rootcoordinator("root",0,tEnd,N1,0,0);
  root.sim();
  out = simout;

  if showPlot
    % plot results
    figure('Position',[1 1 550 350])
    subplot(2,2,1)
    stem(simout.genOut.t,simout.genOut.y);
    grid("on");
    xlim([0 tEnd]);
    ylabel("out");
    xlabel("t");
    title("Generator");

    subplot(2,2,2)
    stem(simout.srvOut.t,simout.srvOut.y);
    grid("on");
    xlim([0 tEnd]);
    ylabel("out");
    xlabel("t");
    title("Server");

    subplot(2,2,3)
    stairs(simout.srvnOut.t,simout.srvnOut.y);
    grid("on");
    xlim([0 tEnd]);
    ylim([0, 1.1])
    ylabel("nS");
    xlabel("t");
    title("Server Load");

    subplot(2,2,4)
    plot(simout.utilOut.t,simout.utilOut.y, '*-');
    grid("on");
    xlim([0 tEnd]);
    ylabel("util");
    xlabel("t");
    title("Server Utilization");
  end
end
