function N = cm_falling_edge(name, tau, debug)
%% Description
%  coupledDEVS create an controller for falling edge detection
%% Ports
%  inputs: 
%    in1
%  outputs: 
%    out 
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally

Not1 = cm_not("not1",tau + [0, 1],debug);
Not2 = cm_not("not2",tau + [0, 1],debug);
Not3 = cm_not("not3",tau + [0, 1],debug);
And = cm_and2("and",tau,debug);

N = coordinator(name);
N.add_model(Not1);
N.add_model(Not2);
N.add_model(Not3);
N.add_model(And);

N.add_coupling(name,"in","not1","in");
N.add_coupling("not1","out","not2","in");

N.add_coupling("not2","out","and","in1");

N.add_coupling(name,"in","not3","in");
N.add_coupling("not3","out","and","in2");

N.add_coupling("and","out",name,"out");
