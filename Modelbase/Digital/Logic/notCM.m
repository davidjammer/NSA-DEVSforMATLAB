function N = notCM(name, tau, debug)
%% Description
%  coupledDEVS create not gate with nand gate
%% Ports
%  inputs: 
%    in1 
%  outputs: 
%    q  
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nnand1 = name + "/nand1";

Nand1 = devs(nand2(nnand1, tau, debug));

N = coordinator(name);
N.add_model(Nand1);

N.add_coupling(name,"in1",nnand1,"in1");
N.add_coupling(name,"in1",nnand1,"in2");

N.add_coupling(nnand1,"out",name,"out");
