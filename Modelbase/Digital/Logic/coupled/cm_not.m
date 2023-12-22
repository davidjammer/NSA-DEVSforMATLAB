function N = cm_not(name, tau, debug)
%% Description
%  coupledDEVS create not gate with nand gate
%% Ports
%  inputs: 
%    in
%  outputs: 
%    q  
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

Nand1 = devs(am_nand2("nand1", tau, debug));

N = coordinator(name);
N.add_model(Nand1);

N.add_coupling(name,"in","nand1","in1");
N.add_coupling(name,"in","nand1","in2");

N.add_coupling("nand1","out",name,"out");
