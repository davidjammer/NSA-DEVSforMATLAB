function N = cm_halfadder(name, tau, debug)
%% Description
%  coupledDEVS create an half adder
%% Ports
%  inputs: 
%    in1   
%    in2
%  outputs: 
%    s
%    c
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

And = cm_and2("and",tau,debug);
Xor = cm_xor2("xor",tau,debug);

N = coordinator(name);
N.add_model(And);
N.add_model(Xor);

N.add_coupling(name,"in1","xor","in1");
N.add_coupling(name,"in2","xor","in2");
N.add_coupling(name,"in1","and","in1");
N.add_coupling(name,"in2","and","in2");

N.add_coupling("xor","out",name,"s");
N.add_coupling("and","out",name,"c");
