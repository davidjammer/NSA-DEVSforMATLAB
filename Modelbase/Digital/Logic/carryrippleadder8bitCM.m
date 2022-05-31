function N = carryrippleadder8bitCM(name, tau, debug)
%% Description
%  coupledDEVS create an full adder
%% Ports
%  inputs: 
%    a1:8
%    b1:8
%    c
%  outputs: 
%    s1:8
%    c -> Cout
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

nfa1 = name + "/fa1";
nfa2 = name + "/fa2";
nfa3 = name + "/fa3";
nfa4 = name + "/fa4";
nfa5 = name + "/fa5";
nfa6 = name + "/fa6";
nfa7 = name + "/fa7";
nfa8 = name + "/fa8";

Fa1 = fulladderCM(nfa1,tau,debug);
Fa2 = fulladderCM(nfa2,tau,debug);
Fa3 = fulladderCM(nfa3,tau,debug);
Fa4 = fulladderCM(nfa4,tau,debug);
Fa5 = fulladderCM(nfa5,tau,debug);
Fa6 = fulladderCM(nfa6,tau,debug);
Fa7 = fulladderCM(nfa7,tau,debug);
Fa8 = fulladderCM(nfa8,tau,debug);

N = coordinator(name);
N.add_model(Fa1);
N.add_model(Fa2);
N.add_model(Fa3);
N.add_model(Fa4);
N.add_model(Fa5);
N.add_model(Fa6);
N.add_model(Fa7);
N.add_model(Fa8);

N.add_coupling(name,"a1",nfa1,"in1");
N.add_coupling(name,"b1",nfa1,"in2");
N.add_coupling(name,"c",nfa1,"in3");

N.add_coupling(name,"a2",nfa2,"in1");
N.add_coupling(name,"b2",nfa2,"in2");
N.add_coupling(nfa1,"c",nfa2,"in3");

N.add_coupling(name,"a3",nfa3,"in1");
N.add_coupling(name,"b3",nfa3,"in2");
N.add_coupling(nfa2,"c",nfa3,"in3");

N.add_coupling(name,"a4",nfa4,"in1");
N.add_coupling(name,"b4",nfa4,"in2");
N.add_coupling(nfa3,"c",nfa4,"in3");

N.add_coupling(name,"a5",nfa5,"in1");
N.add_coupling(name,"b5",nfa5,"in2");
N.add_coupling(nfa4,"c",nfa5,"in3");

N.add_coupling(name,"a6",nfa6,"in1");
N.add_coupling(name,"b6",nfa6,"in2");
N.add_coupling(nfa5,"c",nfa6,"in3");

N.add_coupling(name,"a7",nfa7,"in1");
N.add_coupling(name,"b7",nfa7,"in2");
N.add_coupling(nfa6,"c",nfa7,"in3");

N.add_coupling(name,"a8",nfa8,"in1");
N.add_coupling(name,"b8",nfa8,"in2");
N.add_coupling(nfa7,"c",nfa8,"in3");


N.add_coupling(nfa1,"s",name,"s1");
N.add_coupling(nfa2,"s",name,"s2");
N.add_coupling(nfa3,"s",name,"s3");
N.add_coupling(nfa4,"s",name,"s4");
N.add_coupling(nfa5,"s",name,"s5");
N.add_coupling(nfa6,"s",name,"s6");
N.add_coupling(nfa7,"s",name,"s7");
N.add_coupling(nfa8,"s",name,"s8");

N.add_coupling(nfa8,"c",name,"c");


