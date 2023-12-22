function N = cm_mux2to1(name, tau, debug)
%% Description
%  coupledDEVS create multiplexer
%% Ports
%  inputs: 
%    in1:2 
%    sel
%  outputs: 
%    q  
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

Nand1 = devs(am_nand2("nand1", tau, debug));
Nand2 = devs(am_nand2("nand2", tau, debug));
Nand3 = devs(am_nand2("nand3", tau, debug));
Nand4 = devs(am_nand2("nand4", tau, debug));

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);
N.add_model(Nand3);
N.add_model(Nand4);

N.add_coupling(name,"in1","nand1","in1");
N.add_coupling(name,"in2","nand2","in1");

N.add_coupling(name,"sel","nand2","in2");
N.add_coupling(name,"sel","nand3","in1");
N.add_coupling(name,"sel","nand3","in2");

N.add_coupling("nand3","out","nand1","in2");

N.add_coupling("nand1","out","nand4","in1");
N.add_coupling("nand2","out","nand4","in2");

N.add_coupling("nand4","out",name,"q");
