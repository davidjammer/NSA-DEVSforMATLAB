function N = mux4to1CM(name, tau, debug)
%% Description
%  coupledDEVS create multiplexer
%% Ports
%  inputs: 
%    in1:4 
%    sel1:2
%  outputs: 
%    q  
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nmux1 = name + "/nand1";
nmux2 = name + "/nand2";
nmux3 = name + "/nand3";

Mux1 = mux2to1CM(nmux1, tau, debug);
Mux2 = mux2to1CM(nmux2, tau, debug);
Mux3 = mux2to1CM(nmux3, tau, debug);

N = coordinator(name);
N.add_model(Mux1);
N.add_model(Mux2);
N.add_model(Mux3);

N.add_coupling(name,"in1",nmux1,"in1");
N.add_coupling(name,"in2",nmux1,"in2");
N.add_coupling(name,"in3",nmux2,"in1");
N.add_coupling(name,"in4",nmux2,"in2");

N.add_coupling(nmux1,"q",nmux3,"in1");
N.add_coupling(nmux2,"q",nmux3,"in2");

N.add_coupling(name,"sel1",nmux1,"sel");
N.add_coupling(name,"sel1",nmux2,"sel");

N.add_coupling(name,"sel2",nmux3,"sel");

N.add_coupling(nmux3,"q",name,"q");
