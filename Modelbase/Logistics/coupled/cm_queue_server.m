function [N1] = cm_queue_server(name, ts, tau, debug)
%% Description
%  queue+server with outputs for entity numbers in queue and total 
%% Ports
%  inputs: 
%    in      incoming entities
%  outputs: 
%    out     outgoing entities
%    nqs     number of entities in queue and server
%    nq      number of entities in queue
%%
N1 = coordinator(name);

Fifo1 = devs(am_queue("fifo",tau.*2, tau, debug)); 
Server1 = devs(am_server("server", ts, tau, debug));
add = devs(am_add2("add", tau, debug));

N1.add_model(Fifo1);
N1.add_model(Server1);
N1.add_model(add);

%EIC N1.add_coupling(name, "", "", "");
N1.add_coupling(name, "in", "fifo", "in");

%IC N1.add_coupling("", "", "", "");
N1.add_coupling("fifo", "out", "server", "in");
N1.add_coupling("server", "working", "fifo", "bl");
N1.add_coupling("fifo", "nq", "add", "in1");
N1.add_coupling("server", "n", "add", "in2");

%EOC N1.add_coupling("", "", name, "");
N1.add_coupling("server", "out", name, "out");
N1.add_coupling("add", "out", name, "nqs");
N1.add_coupling("fifo", "nq", name, "nq");

end

