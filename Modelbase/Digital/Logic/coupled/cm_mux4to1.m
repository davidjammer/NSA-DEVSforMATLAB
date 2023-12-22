function N = cm_mux4to1(name, tau, debug)
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


Mux1 = cm_mux2to1("mux1", tau, debug);
Mux2 = cm_mux2to1("mux2", tau, debug);
Mux3 = cm_mux2to1("mux3", tau, debug);

N = coordinator(name);
N.add_model(Mux1);
N.add_model(Mux2);
N.add_model(Mux3);

N.add_coupling(name,"in1","mux1","in1");
N.add_coupling(name,"in2","mux1","in2");
N.add_coupling(name,"in3","mux2","in1");
N.add_coupling(name,"in4","mux2","in2");

N.add_coupling("mux1","q","mux3","in1");
N.add_coupling("mux2","q","mux3","in2");

N.add_coupling(name,"sel1","mux1","sel");
N.add_coupling(name,"sel1","mux2","sel");

N.add_coupling(name,"sel2","mux3","sel");

N.add_coupling("mux3","q",name,"q");
