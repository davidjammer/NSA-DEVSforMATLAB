classdef am_queue < handle
  %% Description
  %  FIFO queue with output of current queue length
  %% Ports
  %  inputs:
  %    in   incoming entities
  %    bl   new blocking status at output
  %  outputs:
  %    out  outgoing entities
  %    nq   queue length
  %% States
  %  s: emptyFree|emptyBlocked|queuingFree|queuingBlocked
  %  q: vector of queued entities
  %% System Parameters
  %  name:  object name
  %  tD:    delay time of the queuingFree state
  %  tau:   input delay
  %  debug: model debug level

  properties
    s
    q
    name
    tau
    tD
    debug
  end

  methods
    function obj = am_queue(name, tD, tau, debug)
      obj.s = "emptyFree";
      obj.q = [];
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
      obj.tD = tD;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end

      [bl, in] = getInput(obj, x);

      switch obj.s
        case "emptyFree"
          if ~isempty(bl) && bl == "1" && isempty(in)
            obj.s = "emptyBlocked";
          elseif ~isempty(bl) && bl == "1" && ~isempty(in)
            obj.s = "queuingBlocked";
            obj.q = [obj.q, in];
          elseif ~isempty(in)
            obj.s = "queuingFree";
            obj.q = [obj.q, in];
          else
            % no entities, bl status remains
          end
        case "emptyBlocked"
          if ~isempty(bl) && bl == "0" && isempty(in)
            obj.s = "emptyFree";
          elseif ~isempty(bl) && bl == "0" && ~isempty(in)
            obj.s = "queuingFree";
            obj.q = [obj.q, in];
          elseif ~isempty(in)
            obj.s = "queuingBlocked";
            obj.q = [obj.q, in];
          else
            % no entities, bl status remains
          end
        case "queuingFree"
          if isempty(x)     % internal event
            if (isscalar(obj.q))
              obj.s = "emptyFree";
            else
              obj.s = "queuingFree";
            end
            obj.q = obj.q(2:end);
          else             % confluent event
            if ~isempty(bl) && bl == "1"
              % blocking has precedence, no entity leaves!
              obj.s = "queuingBlocked";
              obj.q = [obj.q, in];
            else
              obj.q = [obj.q(2:end), in];
              if isempty(obj.q)
                obj.s = "emptyFree";
              else
                obj.s = "queuingFree";
              end
            end
          end
        case "queuingBlocked"
          obj.q = [obj.q, in];
          if isequal(bl, "0")
            obj.s = "queuingFree";
          end
      end

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
      end
    end

    function y = lambda(obj,e,x)
      y = [];     % necessary dummy value for no-op
      [bl, in] = getInput(obj, x);
      nIn = length(in);

      if obj.s == "queuingFree"
        if isequal(bl, "1")
          y.nq = length(obj.q) + nIn;
        else
          y.out = obj.q(1);
          y.nq = length(obj.q) + nIn - 1;
        end
      else
        y.nq = length(obj.q) + nIn;
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      switch obj.s
        case {"emptyFree", "emptyBlocked", "queuingBlocked"}
          t = [Inf,0];
        case "queuingFree"
          t = obj.tD;
      end
    end

    %-------------------------------------------------------
    function [bl, in] = getInput(obj, x)
      % returns input values of bl and in
      % value = [], if there is no input at a port
      if isfield(x, "bl")
        bl = x.bl;
      else
        bl = [];
      end

      if isfield(x, "in")
        in = x.in;
      else
        in = [];
      end
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s q=", obj.s)
      if isempty(obj.q)
        fprintf("[] ");
      else
        fprintf("[ ");
        for I = 1:length(obj.q)-1
          fprintf("%s, ", getDescription(obj.q(I)));
        end
        fprintf("%s]", getDescription(obj.q(end)));
      end
      fprintf("\n")
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in")
        fprintf("[ %s] ", getDescription(x.in));
      end
      if isfield(x, "bl")
        fprintf("bl=%1d", str2double(x.bl));
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "out")
        fprintf("[ %s] ", getDescription(y.out));
      end
      if isfield(y, "nq")
        fprintf("nq=%1d", y.nq);
      end
      fprintf("\n")
    end
  end
end
