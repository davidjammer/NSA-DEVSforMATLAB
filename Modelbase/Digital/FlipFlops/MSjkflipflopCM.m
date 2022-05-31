function N = jkflipflopCM(name, tau, debug)
%% Description
%  coupledDEVS create an master slave JK flip flop with nand gates
%% Ports
%  inputs: 
%    j   jump
%    c   clock
%    k   kill
%    clear
%    preset
%  outputs: 
%    Q  
%    Qn 
%% Parameters
%  name:  object name
%  tau:     infinitesimal delay, internally

nnand1 = name + "/nand1";
nnand2 = name + "/nand2";
nnand3 = name + "/nand3";
nnand4 = name + "/nand4";

nnot1 = name + "/not1";
nnot2 = name + "/not2";
nnot3 = name + "/not3";

Nand1 = nand4CM(nnand1, tau, debug);
Nand2 = nand4CM(nnand2, tau, debug);
Nand3 = devs(nand2(nnand3, tau, debug));
Nand4 = devs(nand2(nnand4, tau + [0, 1], debug));

Not1 = notCM(nnot1,tau,debug);
Not2 = notCM(nnot2,tau,debug);
Not3 = notCM(nnot3,tau,debug);

N = coordinator(name);
N.add_model(Nand1);
N.add_model(Nand2);
N.add_model(Nand3);
N.add_model(Nand4);
N.add_model(Not1);
N.add_model(Not2);
N.add_model(Not3);

N.add_coupling(name,"c",nnot1,"in1");
N.add_coupling(nnot1,"out",nnot2,"in1");
N.add_coupling(nnot2,"out",nnot3,"in1");

N.add_coupling(name,"j",nnand1,"in1");
N.add_coupling(name,"c",nnand1,"in2");
N.add_coupling(nnot3,"out",nnand1,"in3");
N.add_coupling(nnand4,"out",nnand1,"in4");

N.add_coupling(name,"k",nnand2,"in1");
N.add_coupling(name,"c",nnand2,"in2");
N.add_coupling(nnot3,"out",nnand2,"in3");
N.add_coupling(nnand3,"out",nnand2,"in4");

N.add_coupling(nnand1,"out",nnand3,"in1");
N.add_coupling(nnand4,"out",nnand3,"in2");

N.add_coupling(nnand2,"out",nnand4,"in1");
N.add_coupling(nnand3,"out",nnand4,"in2");

N.add_coupling(nnand3,"out",name,"Q");
N.add_coupling(nnand4,"out",name,"Qn");





