function N = DflipflopFCM(name, tau, debug)
%% Description
%  coupledDEVS create an D flip flop with edge controll with nand gates
%% Ports
%  inputs: 
%    D   data
%    C   clock
%  outputs: 
%    Q  
%    Qn 
%% Parameters
%  name:  object name
%  tau:     infinitesimal delay, internally

ndff = name + "/dff";
nre = name +"/re";

DFF = DflipflopCM(ndff,tau,debug);
RE = rising_edgeCM(nre,tau + [0, 10],debug);

N = coordinator(name);
N.add_model(DFF);
N.add_model(RE);

N.add_coupling(name,"D",ndff,"D");
N.add_coupling(name,"C",nre,"in1");

N.add_coupling(nre,"out",ndff,"E");


N.add_coupling(ndff,"Q",name,"Q");
N.add_coupling(ndff,"Qn",name,"Qn");



