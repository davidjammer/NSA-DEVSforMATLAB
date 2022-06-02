function compswitch()
% different testcases:
%  1     all tauDef, rOut late   (default)
%  2     all tauDef, rOut early
%  3     like 2, but with mi != 0
%  4     tauSwitch late, rOut early
global simout
global epsilon
global DEBUGLEVEL
global mi

if nargin == 0
  testcase = 1;
end


mi = 0;
rSwitch = 1.0;


simout = [];
DEBUGLEVEL = 1;           % simulator debug level
epsilon = 1e-6;

tVec = [1, 3, 7, 8, 9];
yVec = [2, -3, -2, 1, -1];
tEnd = 2;
mdebug = false;

N1 = coordinator("N1");

Vectorgen = devs(vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
Comparator = devs(comparator("Comparator", [0, 1], mdebug));
Outputswitch = devs(outputswitch("Outputswitch", 1, [0, rSwitch], mdebug));
Terminator1 = devs(terminator("Terminator1", [0, 1], mdebug));
Terminator2 = devs(terminator("Terminator2", [0, 1], mdebug));


N1.add_model(Vectorgen);
N1.add_model(Comparator);
N1.add_model(Outputswitch);
N1.add_model(Terminator1);
N1.add_model(Terminator2);


N1.add_coupling("Vectorgen","out","Comparator","in");
N1.add_coupling("Vectorgen","out","Outputswitch","in");
N1.add_coupling("Comparator","out","Outputswitch","sw");
N1.add_coupling("Outputswitch","out1","Terminator1","in");
N1.add_coupling("Outputswitch","out2","Terminator2","in");


root = rootcoordinator("root",0,tEnd,N1,0);
root.sim();



