function N = shiftregisterCM(name, tau, debug)
%% Description
% shift register as coupledDEVS
%% Ports
%  inputs: 
%    in, clk
%  outputs: 
%    out1, out2, out3, out4
%% System Parameters
%  name:  object name
%  debug: model debug level
%  tau:     infinitesimal delay

Notgate = devs(notgate("Notgate", tau, debug));
JKFF1 = devs(jkflipflop("JKFF1", 0, tau, debug));
JKFF2 = devs(jkflipflop("JKFF2", 0, tau, debug));
JKFF3 = devs(jkflipflop("JKFF3", 0, tau, debug));
JKFF4 = devs(jkflipflop("JKFF4", 0, tau, debug));
Terminator1 = devs(terminator("Terminator1", tau, debug));

N = coordinator(name);
N.add_model(Notgate);
N.add_model(JKFF1);
N.add_model(JKFF2);
N.add_model(JKFF3);
N.add_model(JKFF4);
N.add_model(Terminator1);

N.add_coupling(name,"in","Notgate","in");
N.add_coupling(name,"in","JKFF1","j");
N.add_coupling("Notgate","out","JKFF1","k");
N.add_coupling(name,"clk","JKFF1","clk");
N.add_coupling(name,"clk","JKFF2","clk");
N.add_coupling(name,"clk","JKFF3","clk");
N.add_coupling(name,"clk","JKFF4","clk");

N.add_coupling("JKFF1","q","JKFF2","j");
N.add_coupling("JKFF1","qb","JKFF2","k");
N.add_coupling("JKFF2","q","JKFF3","j");
N.add_coupling("JKFF2","qb","JKFF3","k");
N.add_coupling("JKFF3","q","JKFF4","j");
N.add_coupling("JKFF3","qb","JKFF4","k");
N.add_coupling("JKFF4","qb","Terminator1","in");

N.add_coupling("JKFF1","q",name,"out1");
N.add_coupling("JKFF2","q",name,"out2");
N.add_coupling("JKFF3","q",name,"out3");
N.add_coupling("JKFF4","q",name,"out4");
