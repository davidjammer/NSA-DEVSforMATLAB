function N = rising_edgeCM(name, tau, debug)
%% Description
%  coupledDEVS create an controller for rising edge detection
%% Ports
%  inputs: 
%    in1
%  outputs: 
%    out 
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nnot = name + "/not";
nand = name + "/and";

Not = notCM(nnot,tau + [0, 1],debug);
And = and2CM(nand,tau,debug);

N = coordinator(name);
N.add_model(Not);
N.add_model(And);

N.add_coupling(name,"in1",nnot,"in1");
N.add_coupling(name,"in1",nand,"in2");
N.add_coupling(nnot,"out",nand,"in1");

N.add_coupling(nand,"out",name,"out");
