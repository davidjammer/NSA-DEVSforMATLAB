classdef terminator1 < handle
%% Description
%  terminates incoming entities
%  send number of terminated entities to global variable simout
%% Ports
%  inputs:
%    in       incoming entities
%  outputs: none
%% States
%  ni:  number of terminated entities
%  s:   running
%  t:   time of last input
%% System Parameters
%  name:     object name
%  varname:  name of output field 

  properties
    tau
    t
    ni
    s
    name
    varname
  end
  
  methods
    function obj = terminator1(name, varname, t0, tau)
      obj.name = name;
      obj.varname = varname;
      obj.s = "running";
      obj.t = t0;
      obj.ni = 0;
      obj.tau = tau;
    end
    
    function delta(obj,e,x)
      obj.ni = obj.ni + 1;
      doOut(obj, e);
    end
    
    function y=lambda(obj,e,x)
      y=[];
    end
       
    function t = ta(obj)
      t = [Inf, 0];
    end
    
    function doOut(obj, e)
      global simout
      fun = @(x) strcmp(x,obj.varname);
      obj.t = obj.t + e;
      if (isempty(simout))
        simout.(obj.varname).y=obj.ni;
        simout.(obj.varname).t=obj.t(1);
      elseif ( ~any(fun(fieldnames(simout))) )
        simout.(obj.varname).y=obj.ni;
        simout.(obj.varname).t=obj.t(1);
      else
        simout.(obj.varname).y=[simout.(obj.varname).y,obj.ni];
        simout.(obj.varname).t=[simout.(obj.varname).t,obj.t(1)];
      end
    end
    
  end
end
