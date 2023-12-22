function N = cm_carry_ripple_adder_8bit(name, tau, debug)
%% Description
%  coupledDEVS create an full adder
%% Ports
%  inputs: 
%    a1:8
%    b1:8
%    cin
%  outputs: 
%    s1:8
%    cout
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

Fa1 = cm_fulladder("fa1",tau,debug);
Fa2 = cm_fulladder("fa2",tau,debug);
Fa3 = cm_fulladder("fa3",tau,debug);
Fa4 = cm_fulladder("fa4",tau,debug);
Fa5 = cm_fulladder("fa5",tau,debug);
Fa6 = cm_fulladder("fa6",tau,debug);
Fa7 = cm_fulladder("fa7",tau,debug);
Fa8 = cm_fulladder("fa8",tau,debug);

N = coordinator(name);
N.add_model(Fa1);
N.add_model(Fa2);
N.add_model(Fa3);
N.add_model(Fa4);
N.add_model(Fa5);
N.add_model(Fa6);
N.add_model(Fa7);
N.add_model(Fa8);

N.add_coupling(name,"a1","fa1","in1");
N.add_coupling(name,"b1","fa1","in2");
N.add_coupling(name,"cin","fa1","in3");

N.add_coupling(name,"a2","fa2","in1");
N.add_coupling(name,"b2","fa2","in2");
N.add_coupling("fa1","c","fa2","in3");

N.add_coupling(name,"a3","fa3","in1");
N.add_coupling(name,"b3","fa3","in2");
N.add_coupling("fa2","c","fa3","in3");

N.add_coupling(name,"a4","fa4","in1");
N.add_coupling(name,"b4","fa4","in2");
N.add_coupling("fa3","c","fa4","in3");

N.add_coupling(name,"a5","fa5","in1");
N.add_coupling(name,"b5","fa5","in2");
N.add_coupling("fa4","c","fa5","in3");

N.add_coupling(name,"a6","fa6","in1");
N.add_coupling(name,"b6","fa6","in2");
N.add_coupling("fa5","c","fa6","in3");

N.add_coupling(name,"a7","fa7","in1");
N.add_coupling(name,"b7","fa7","in2");
N.add_coupling("fa6","c","fa7","in3");

N.add_coupling(name,"a8","fa8","in1");
N.add_coupling(name,"b8","fa8","in2");
N.add_coupling("fa7","c","fa8","in3");


N.add_coupling("fa1","s",name,"s1");
N.add_coupling("fa2","s",name,"s2");
N.add_coupling("fa3","s",name,"s3");
N.add_coupling("fa4","s",name,"s4");
N.add_coupling("fa5","s",name,"s5");
N.add_coupling("fa6","s",name,"s6");
N.add_coupling("fa7","s",name,"s7");
N.add_coupling("fa8","s",name,"s8");

N.add_coupling("fa8","c",name,"cout");


