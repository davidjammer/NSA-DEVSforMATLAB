function N = cm_and2(name, tau, debug)
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

Nand1 = devs(am_nand2("nand1", tau, debug));
Nand2 = devs(am_nand2("nand2", tau, debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);

N.add_coupling(name,"in1","nand1","in1");
N.add_coupling(name,"in2","nand1","in2");

N.add_coupling("nand1","out","nand2","in1");
N.add_coupling("nand1","out","nand2","in2");

N.add_coupling("nand2","out",name,"out");
