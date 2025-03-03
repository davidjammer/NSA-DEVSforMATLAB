classdef am_toworkspace < handle
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
  %  name:  object name
  %  varname: field name of simout to store x values
  %  t0:      time of initial time stamp
  %  format:  vector -> save x values in vector, single -> save the last value
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    t
    name
    varname
    format
    mu
    tau
    debug
  end

  methods
    function obj = am_toworkspace(name,varname,t0,format,tau,debug)
      obj.s = "running";
      obj.t = t0;
      obj.name = name;
      obj.varname = varname;
      obj.tau = tau;
      obj.mu = get_mu();
      obj.debug = debug;
      obj.format = format;
      
    end

    function delta(obj,e,x)
      global simout
      fun = @(x) strcmp(x,obj.varname);

      obj.t = obj.t(1) + e(1) + e(2) * obj.mu;
      if ~isempty(x) && isfield(x,"in") && ~isempty(x.in)
        if isempty(simout) || ~any(fun(fieldnames(simout)))
          simout.(obj.varname).y = x.in(end);
          simout.(obj.varname).t = obj.t;
        else
          if obj.format == "vector"
            simout.(obj.varname).y = [simout.(obj.varname).y,x.in(end)];
            simout.(obj.varname).t = [simout.(obj.varname).t,obj.t];
          else
            simout.(obj.varname).y = x.in(end);
            simout.(obj.varname).t = obj.t;
          end
        end
      end

      if obj.debug
       if isfield(x, "in")
          fprintf("%-8s delta, in=%f\n", obj.name, x.in)
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
