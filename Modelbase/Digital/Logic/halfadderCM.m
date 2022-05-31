function N = halfadderCM(name, tau, debug)
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

nxor = name + "/xor";
nand = name + "/and";

And = and2CM(nand,tau,debug);
Xor = xor2CM(nxor,tau,debug);

N = coordinator(name);
N.add_model(And);
N.add_model(Xor);

N.add_coupling(name,"in1",nxor,"in1");
N.add_coupling(name,"in2",nxor,"in2");
N.add_coupling(name,"in1",nand,"in1");
N.add_coupling(name,"in2",nand,"in2");

N.add_coupling(nxor,"out",name,"s");
N.add_coupling(nand,"out",name,"c");
