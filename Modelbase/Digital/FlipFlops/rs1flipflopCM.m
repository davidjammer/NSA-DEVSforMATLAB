function N = rs1flipflopCM(name, tau, debug)
%% Description
%  coupledDEVS create an RS flip flop with clock level control with nand gates
%% Ports
%  inputs: 
%    S   set
%    R   reset
%    C   enable
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
Nand2 = devs(nand2(nnand2, tau, debug));
Nand3 = devs(nand2(nnand3, tau, debug));
Nand4 = devs(nand2(nnand4, tau + [0, 1], debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);
N.add_model(Nand3);
N.add_model(Nand4);

N.add_coupling(name,"S",nnand1,"in1");
N.add_coupling(name,"R",nnand2,"in1");
N.add_coupling(name,"C",nnand1,"in2");
N.add_coupling(name,"C",nnand2,"in2");

N.add_coupling(nnand1,"out",nnand3,"in1");
N.add_coupling(nnand2,"out",nnand4,"in1");

N.add_coupling(nnand4,"out",nnand3,"in2");
N.add_coupling(nnand3,"out",nnand4,"in2");

N.add_coupling(nnand3,"out",name,"Q");
N.add_coupling(nnand4,"out",name,"Qn");
