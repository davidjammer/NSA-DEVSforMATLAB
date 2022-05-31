function testServer(testcase)
global simout
global epsilon
global DEBUGLEVEL
global mi
if nargin == 0
  testcase = 1;
end

mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

switch testcase
  case 1   % generator too fast -> loosing entities
    tG = 1.0;
  case 2   % correct behaviour
    tG = 2.0;
  otherwise
    tG = 2.0;
end

tS = 1.5;
tEnd = 8;
mdebug = false;               % model debug level
rOut = 3.0;

N1 = coordinator("N1");

Generator = devs(generator1("Generator", tG, 1, 5, [0, 1], mdebug));
Server = devs(server("Server", tS, [0, 1], mdebug));
Terminator = devs(terminator("Terminator", [0, 1], mdebug));
GenOut = devs(toworkspace("GenOut", "genOut", 0, [0, rOut]));
SrvOut = devs(toworkspace("SrvOut", "srvOut", 0, [0, rOut]));
SrvNOut = devs(toworkspace("SrvNOut", "srvnOut", 0, [0, rOut]));

N1.add_model(Generator);
N1.add_model(Server);
N1.add_model(Terminator);
N1.add_model(GenOut);
N1.add_model(SrvOut);
N1.add_model(SrvNOut);

N1.add_coupling("Generator","out","Server","in");
N1.add_coupling("Server","out","Terminator","in");
N1.add_coupling("Generator","out","GenOut","in");
N1.add_coupling("Server","out","SrvOut","in");
N1.add_coupling("Server","n","SrvNOut","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

% plot results
figure("name", "testServer", "NumberTitle", "off")
subplot(3,1,1)
stem(simout.genOut.t,simout.genOut.y); grid on;
xlim([0 tEnd]);
xlabel("simulation time");
ylabel("out");
title("Generator");

subplot(3,1,2)
stairs(simout.srvnOut.t,simout.srvnOut.y); grid on;
hold("on");plot(simout.srvnOut.t,simout.srvnOut.y, "*");hold("off");
xlim([0 tEnd]);
ylim([-0.1, 1.1])
xlabel("simulation time");
ylabel("n");
title("Server");

subplot(3,1,3)
stem(simout.srvOut.t,simout.srvOut.y); grid on;
xlim([0 tEnd]);
xlabel("simulation time");
ylabel("out");
title("Server");
