function N = rsflipflopCM(name, tau, debug)
%% Description
%  coupledDEVS create an asynchronous RS flip flop with nand gates
%% Ports
%  inputs: 
%    S   set
%    R   reset
%  outputs: 
%    Q  
%    Qn 
%% Parameters
%  name:  object name
%  tau:     infinitesimal delay, internally

nnand1 = name + "/nand1";
nnand2 = name + "/nand2";
nnand3 = name + "/nand3";
nnand4 = name + "/nand4";

Nand1 = devs(nand2(nnand1, tau, debug));
Nand2 = devs(nand2(nnand2, tau + [0, 1], debug));
Nand3 = devs(nand2(nnand3, tau, debug));
Nand4 = devs(nand2(nnand4, tau, debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);
N.add_model(Nand3);
N.add_model(Nand4);

N.add_coupling(name,"S",nnand3,"in1");
N.add_coupling(name,"S",nnand3,"in2");
N.add_coupling(name,"R",nnand4,"in1");
N.add_coupling(name,"R",nnand4,"in2");

N.add_coupling(nnand3,"out",nnand1,"in1");
N.add_coupling(nnand2,"out",nnand1,"in2");

N.add_coupling(nnand4,"out",nnand2,"in1");
N.add_coupling(nnand1,"out",nnand2,"in2");

N.add_coupling(nnand1,"out",name,"Q");
N.add_coupling(nnand2,"out",name,"Qn");
