function [N1] = queue_en(name, tau)
%% Description
%  
%% Ports
%  inputs: 
%  in
%  enable
%  bl
%  outputs: 
%  out
%  nq
%%
N1 = coordinator(name);

Fifo1 = devs(queue("fifo",tau, 0, tau)); 
or1 = devs(or_devs("or1",[0,1],0,0,0));
not1 = devs(not_devs("not1",[0,1],0));

N1.add_model(Fifo1);
N1.add_model(or1);
N1.add_model(not1);

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

