function testGenerator1()
global simout
global epsilon
global DEBUGLEVEL
global mi
mi = 0.0;
simout = [];
DEBUGLEVEL = 0;           % simulator debug level
epsilon = 1e-6;

tG = 0.9;
n0 = 2;
nG = 7;
tEnd = 10;
mdebug = false;               % model debug level
rOut = 3.0;

N1 = coordinator('N1');

Generator = devs(generator1("Generator", tG, n0, nG, [0, 1], mdebug));
Genout = devs(toworkspace("Genout", "genOut", 0, [0, rOut]));
Terminator = devs(terminator("Terminator", [0, 1], mdebug));

N1.add_model(Generator);
N1.add_model(Terminator);
N1.add_model(Genout);

N1.add_coupling("Generator","out","Terminator","in");
N1.add_coupling("Generator","out","Genout","in");

root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();

figure("name", "testGenerator1", "NumberTitle", "off")
stem(simout.genOut.t,simout.genOut.y); grid on;
xlim([0 tEnd]);
ylim([0 9]);
xlabel("simulation time");
ylabel("out");
title("testGenerator1");