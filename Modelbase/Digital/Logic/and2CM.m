function N = and2CM(name, tau, debug)
%% Description
%  coupledDEVS create and gate with nand gates
%% Ports
%  inputs: 
%    in1   
%    in2
%  outputs: 
%    q  
%    qn 
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nnand1 = name + "/nand1";
nnand2 = name + "/nand2";

Nand1 = devs(nand2(nnand1, tau, debug));
Nand2 = devs(nand2(nnand2, tau, debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);

N.add_coupling(name,"in1",nnand1,"in1");
N.add_coupling(name,"in2",nnand1,"in2");

N.add_coupling(nnand1,"out",nnand2,"in1");
N.add_coupling(nnand1,"out",nnand2,"in2");

N.add_coupling(nnand2,"out",name,"out");
