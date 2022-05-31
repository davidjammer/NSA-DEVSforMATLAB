function N = falling_edgeCM(name, tau, debug)
%% Description
%  coupledDEVS create an controller for falling edge detection
%% Ports
%  inputs: 
%    in1
%  outputs: 
%    out 
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nnot1 = name + "/not1";
nnot2 = name + "/not2";
nnot3 = name + "/not3";
nand = name + "/and";

Not1 = notCM(nnot1,tau + [0, 1],debug);
Not2 = notCM(nnot2,tau + [0, 1],debug);
Not3 = notCM(nnot3,tau + [0, 1],debug);
And = and2CM(nand,tau,debug);

N = coordinator(name);
N.add_model(Not1);
N.add_model(Not2);
N.add_model(Not3);
N.add_model(And);

N.add_coupling(name,"in1",nnot1,"in1");
N.add_coupling(nnot1,"out",nnot2,"in1");

N.add_coupling(nnot2,"out",nand,"in1");

N.add_coupling(name,"in1",nnot3,"in1");
N.add_coupling(nnot3,"out",nand,"in2");

N.add_coupling(nand,"out",name,"out");
