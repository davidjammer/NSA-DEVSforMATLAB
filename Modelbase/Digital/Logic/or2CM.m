function N = or2CM(name, tau, debug)
%% Description
%  coupledDEVS create or gate with nand gates
%% Ports
%  inputs: 
%    in1   
%    in2
%  outputs: 
%    out  
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nnand1 = name + "/nand1";
nnand2 = name + "/nand2";
nnand3 = name + "/nand3";

Nand1 = devs(nand2(nnand1, tau, debug));
Nand2 = devs(nand2(nnand2, tau, debug));
Nand3 = devs(nand2(nnand3, tau, debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);
N.add_model(Nand3);

N.add_coupling(name,"in1",nnand1,"in1");
N.add_coupling(name,"in1",nnand1,"in2");

N.add_coupling(name,"in2",nnand2,"in1");
N.add_coupling(name,"in2",nnand2,"in2");

N.add_coupling(nnand1,"out",nnand3,"in1");
N.add_coupling(nnand2,"out",nnand3,"in2");


N.add_coupling(nnand3,"out",name,"out");
