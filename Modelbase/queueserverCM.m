function N = queueserverCM(name, tS, tau, tauOut, debug)
%% Description
%  coupledDEVS combining queue and server
%  contains internal toworkspace to store the current queue length
%      in name+"/qnOut"
%% Ports
%  inputs: 
%    in   incoming entities
%  outputs: 
%    out  outgoing entities
%    n    total number of entities in queue and server
%% Parameters
%  name:  object name
%  tS: service time
%  debug: flag to output debugging infos
%  tau:     infinitesimal delay, internally
%  tauOut:  infinitesimal delay, output

nQueue = name + "/Queue";
nServer = name + "/Server";
nAdd2 = name + "/Add2";
nQnOut = name + "/QnOut";
nqnOut = name + "_qnOut";

Queue = devs(queue(nQueue, 3*tau, debug));
Server = devs(server(nServer, tS, tau, debug));
Add2 = devs(add2(nAdd2, tau, debug));
QnOut = devs(toworkspace(nQnOut, nqnOut, 0, tauOut));

N = coordinator(name);
N.add_model(Queue);
N.add_model(Server);
N.add_model(Add2);
N.add_model(QnOut);

N.add_coupling(name,"in",nQueue,"in");
N.add_coupling(nServer,"out",name,"out");
N.add_coupling(nAdd2,"out",name,"n");
N.add_coupling(nQueue,"out",nServer,"in");
N.add_coupling(nQueue,"nq",nAdd2,"in2");
N.add_coupling(nQueue,"nq",nQnOut,"in");
N.add_coupling(nServer,"working",nQueue,"bl");
N.add_coupling(nServer,"n",nAdd2,"in1");
