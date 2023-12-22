function [N1] = cm_queue_en(name, tau, debug)
%% Description
%  queue with additionable enable input
%% Ports
%  inputs: 
%    in      incoming entities
%    enable  enable = 0 -> output is generally blocked
%    bl      blocking input: denotes "out = blocked"
%  outputs: 
%    out     outgoing entities
%    nq      number of entities in queue
%%
N1 = coordinator(name);

Fifo1 = devs(am_queue("fifo",tau.*3, tau, debug)); 
OR = devs(am_or2("or1", [0,1], debug));
NOT = devs(am_not("not1", [0,1], debug));

N1.add_model(Fifo1);
N1.add_model(OR);
N1.add_model(NOT);

%EIC N1.add_coupling(name, "", "", "");
N1.add_coupling(name, "in", "fifo", "in");
N1.add_coupling(name, "enable", "not1", "in");
N1.add_coupling(name, "bl", "or1", "in2");

%IC N1.add_coupling("", "", "", "");
N1.add_coupling("not1", "out", "or1", "in1");
N1.add_coupling("or1", "out", "fifo", "bl");

%EOC N1.add_coupling("", "", name, "");
N1.add_coupling("fifo", "out", name, "out");
N1.add_coupling("fifo", "nq", name, "nq");

end

