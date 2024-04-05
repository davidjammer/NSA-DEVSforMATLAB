classdef am_utilization < handle
  %% Description
  %  calculates the utilization from an activity input (being 1 or 0)
  %% Ports
  %  inputs:
  %    in    activity, "0" = inactive, "1" = active
  %  outputs:
  %    out   utilization = (time of activity) / (total time)
  %% States
  %  s:           idle/working
  %  time:        time between state changes
  %  active_time: total time of activity
  %  total_time:  total time
  %% System Parameters
  %  name:  object name
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    active_time
    total_time
    time
    name
    tau
    debug
  end

  methods
    function obj = am_utilization(name, tau, debug)
      obj.s = "idle";
      obj.active_time = 0;
      obj.total_time = 0;
      obj.time = 0;
      obj.name = name;
      obj.tau = tau;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      obj.time = obj.time + e(1);
      if ~isempty(x)
        % convert to numeric, if necessary
        if isfield(x, "in") 
          inVal = input2double(obj, x.in);
        end

        if isfield(x, "in") && inVal == 1
          if obj.s == "idle"
            obj.total_time = obj.total_time + obj.time;
            obj.s = "working";
            obj.time = 0;
          end
        elseif isfield(x, "in") && inVal == 0
          if obj.s == "working"
            obj.total_time = obj.total_time + obj.time;
            obj.active_time = obj.active_time + obj.time;
            obj.s = "idle";
            obj.time = 0;
          end
        end
      end
    end

    function y = lambda(obj,e,x)
      t = obj.time + e(1);
      total_time = obj.total_time;
      active_time = obj.active_time;

      if ~isempty(x)
        % convert to numeric, if necessary
        if isfield(x, "in") 
          inVal = input2double(obj, x.in);
        end

        if isfield(x, "in") && inVal == 1
          if obj.s == "idle"
            total_time = obj.total_time + t;
          end
        elseif isfield(x, "in") && inVal == 0
          if obj.s == "working"
            total_time = obj.total_time + t;
            active_time = obj.active_time + t;
          end
        end
      end
      y.out = active_time/total_time;
    end

    function t = ta(obj)
      t = [inf, 0];
    end

    % internal functions
    function val = input2double(obj, inVal)
      % converts inVal to double, if necessary
      if isnumeric(inVal)
        val = inVal;
      else
        val = str2double(inVal);
      end
    end

  end
end
