function N = cm_fulladder(name, tau, debug)
%% Description
%  coupledDEVS create an full adder
%% Ports
%  inputs: 
%    in1 -> x   
%    in2 -> y
%    in3 -> Cin
%  outputs: 
%    s
%    c -> Cout
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

Ha1 = cm_halfadder("ha1",tau,debug);
Ha2 = cm_halfadder("ha2",tau,debug);
Or = cm_or2("or",tau,debug);

N = coordinator(name);
N.add_model(Ha1);
N.add_model(Ha2);
N.add_model(Or);

N.add_coupling(name,"in1","ha1","in1");
N.add_coupling(name,"in2","ha1","in2");

N.add_coupling("ha1","s","ha2","in1");
N.add_coupling(name,"in3","ha2","in2");

N.add_coupling("ha1","c","or","in1");
N.add_coupling("ha2","c","or","in2");

N.add_coupling("ha2","s",name,"s");
N.add_coupling("or","out",name,"c");
