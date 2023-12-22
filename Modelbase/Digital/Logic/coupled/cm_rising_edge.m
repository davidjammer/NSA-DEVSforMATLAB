function N = cm_rising_edge(name, tau, debug)
%% Description
%  coupledDEVS create an controller for rising edge detection
%% Ports
%  inputs: 
%    in
%  outputs: 
%    out 
%% Parameters
%  name:  object name
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally


Not = cm_not("not",tau + [0, 1],debug);
And = cm_and2("and",tau,debug);

N = coordinator(name);
N.add_model(Not);
N.add_model(And);

N.add_coupling(name,"in","not","in");
N.add_coupling(name,"in","and","in2");
N.add_coupling("not","out","and","in1");

N.add_coupling("and","out",name,"out");
