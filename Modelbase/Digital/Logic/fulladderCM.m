function N = fulladderCM(name, tau, debug)
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

nha1 = name + "/ha1";
nha2 = name + "/ha2";
nor = name + "/or";

Ha1 = halfadderCM(nha1,tau,debug);
Ha2 = halfadderCM(nha2,tau,debug);
Or = or2CM(nor,tau,debug);

N = coordinator(name);
N.add_model(Ha1);
N.add_model(Ha2);
N.add_model(Or);

N.add_coupling(name,"in1",nha1,"in1");
N.add_coupling(name,"in2",nha1,"in2");

N.add_coupling(nha1,"s",nha2,"in1");
N.add_coupling(name,"in3",nha2,"in2");

N.add_coupling(nha1,"c",nor,"in1");
N.add_coupling(nha2,"c",nor,"in2");

N.add_coupling(nha2,"s",name,"s");
N.add_coupling(nor,"out",name,"c");
