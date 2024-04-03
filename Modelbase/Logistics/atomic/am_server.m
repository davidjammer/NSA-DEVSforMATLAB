classdef am_server < handle
%% Description
%  processes one entity in time tS
%% Ports
%  inputs: 
%    in   incoming entities
%  outputs: 
%    out      outgoing entities
%    working  "1"/"0"
%    n        current number of entities in server
%% States
%  s:   idle|busy
%  E:   id of processed entity
%  sig: next switching time
%% System Parameters
%  name:  object name
%  tS:    service time
%  tau:   input delay
%  debug: model debug level

  properties
    s
    E
    sig
    name
    tS
    tau
    debug
    epsilon
  end
  
  methods
    function obj = am_server(name, tS, tau, debug)
      obj.s = "idle";
      obj.E = [];
      obj.sig = [inf,0];
      obj.name = name;
      obj.tS = tS;
      obj.debug = debug;
      obj.epsilon = get_epsilon();
      obj.tau = tau;
     end
    
		function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta,", obj.name)
        showState(obj);
      end      

      if isempty(x)      % internal event
        obj.s = "idle";
        obj.E = [];
        obj.sig = [inf,0];
      elseif (e(1) < obj.sig(1) - obj.epsilon)   % external event
        switch obj.s 
          case "idle"
            if ~isempty(x.in)
              obj.s = "busy";
              obj.E = x.in;
              obj.sig = [obj.tS,0];
            end
          case "busy"
            if ~isempty(x.in)
              fprintf("%s, in delta, phase %s - dropping input %2d\n", ...
                 obj.name, obj.s, x.in)
              obj.sig = obj.sig - e;   % adjust waiting time
            end
          otherwise
            fprintf("delta: wrong phase %s in %s\n", obj.s, obj.name);
        end
      else   % confluent event
        if ~isempty(x.in)
         obj.s = "busy";     % unnecessary, is busy anyhow
         obj.E = x.in;
         obj.sig = [obj.tS,0];
        end
      end

      if obj.debug
        fprintf("%-8s leaving  delta,", obj.name)
        showState(obj);
      end      
    end
    
    function y = lambda(obj,e,x)
      y = [];     % necessary dummy value for no-op
      if isempty(x)      % internal event
        y.out = obj.E;
        y.working = "0";
        y.n = 0;
      elseif (e(1) < obj.sig(1))   % external event
        if obj.s == "idle"
          %y.out = [];   % leads to errors!
          y.working = "1";
          y.n = 1;
        end
      else   % confluent event
        y.out = obj.E;
        y.working = "1";
        y.n = 1;
      end
      
      if obj.debug
        fprintf("%-8s lambda, ", obj.name);
        if isfield(y, "out")
          fprintf("out=%2d ", y.out);
        end
        if isfield(y, "working")
          fprintf("working=%1d ", y.working);
        end
        if isfield(y, "n")
          fprintf("n=%1d", y.n);
        end
        fprintf("\n")
      end
    end
    
    function t = ta(obj)
      t = obj.sig;
    end
    
    %-------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%4s E=%1d sig=[%4.2f,%4.2f]\n",...
            obj.s, obj.E, obj.sig(1), obj.sig(2))
    end
   
  end
end
