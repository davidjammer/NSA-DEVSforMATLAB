classdef toworkspace < handle
%% Description
%  stores time and value of incoming events in global variable
%    simout.VARNAME in fields t and y
%% Ports
%  inputs: 
%    in        incoming value
%  outputs: 
%    none
%% States
%  s: running
%  t: time of last event for time stamp
%% System Parameters
%  name:    object name
%  varname: field name of simout to store x values
%  mi:      if non-zero: small time value to represent epsilon
%  tau:     infinitesimal delay

  properties
    s
    t
    name
    varname
    epsilon
    mi
    tau
  end
  
  methods
    function obj = toworkspace(name,varname,t0,tau)
      obj.s = "running";
      obj.t = t0;
      obj.name = name;
      obj.varname = varname;
      obj.tau = tau;
      obj.mi = get_mi();
      obj.epsilon = get_epsilon();
    end
        
    function delta(obj,e,x)
      global simout
      fun = @(x) strcmp(x,obj.varname);
            
      obj.t = obj.t(1) + e(1) + e(2) * obj.mi;            
      if ~isempty(x) && isfield(x,"in") && ~isempty(x.in)              
        if isempty(simout) || ~any(fun(fieldnames(simout)))
          simout.(obj.varname).y = x.in(end);
          simout.(obj.varname).t = obj.t;
        else
          simout.(obj.varname).y = [simout.(obj.varname).y,x.in(end)];
          simout.(obj.varname).t = [simout.(obj.varname).t,obj.t];
        end
      end
    end
       
    function y=lambda(obj,e,x)
      y=[];
    end
    
    function t = ta(obj)
      t = [Inf,0];
    end
    
  end 
end
