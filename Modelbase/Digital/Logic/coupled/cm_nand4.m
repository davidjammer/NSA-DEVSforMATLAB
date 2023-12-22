function N = cm_nand4(name, tau, debug)
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

Nand1 = devs(am_nand2("nand1", tau, debug));
Nand2 = devs(am_nand2("nand2", tau, debug));
Nand3 = devs(am_nand2("nand3", tau, debug));
Nand4 = devs(am_nand2("nand4", tau, debug));
Nand5 = devs(am_nand2("nand5", tau, debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);
N.add_model(Nand3);
N.add_model(Nand4);
N.add_model(Nand5);

N.add_coupling(name,"in1","nand1","in1");
N.add_coupling(name,"in2","nand1","in2");
N.add_coupling(name,"in3","nand2","in1");
N.add_coupling(name,"in4","nand2","in2");

N.add_coupling("nand1","out","nand3","in1");
N.add_coupling("nand1","out","nand3","in2");
N.add_coupling("nand2","out","nand4","in1");
N.add_coupling("nand2","out","nand4","in2");

N.add_coupling("nand3","out","nand5","in1");
N.add_coupling("nand4","out","nand5","in2");

N.add_coupling("nand5","out",name,"out");
