function N = nand4CM(name, tau, debug)
%% Description
%  coupledDEVS create nand gate with 4 inputs with nand gate
%% Ports
%  inputs: 
%    in1:4 
%  outputs: 
%    out  
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nnand1 = name + "/nand1";
nnand2 = name + "/nand2";
nnand3 = name + "/nand3";
nnand4 = name + "/nand4";
nnand5 = name + "/nand5";

Nand1 = devs(nand2(nnand1, tau, debug));
Nand2 = devs(nand2(nnand2, tau, debug));
Nand3 = devs(nand2(nnand3, tau, debug));
Nand4 = devs(nand2(nnand4, tau, debug));
Nand5 = devs(nand2(nnand5, tau, debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);
N.add_model(Nand3);
N.add_model(Nand4);
N.add_model(Nand5);

N.add_coupling(name,"in1",nnand1,"in1");
N.add_coupling(name,"in2",nnand1,"in2");
N.add_coupling(name,"in3",nnand2,"in1");
N.add_coupling(name,"in4",nnand2,"in2");

N.add_coupling(nnand1,"out",nnand3,"in1");
N.add_coupling(nnand1,"out",nnand3,"in2");
N.add_coupling(nnand2,"out",nnand4,"in1");
N.add_coupling(nnand2,"out",nnand4,"in2");

N.add_coupling(nnand3,"out",nnand5,"in1");
N.add_coupling(nnand4,"out",nnand5,"in2");

N.add_coupling(nnand5,"out",name,"out");
