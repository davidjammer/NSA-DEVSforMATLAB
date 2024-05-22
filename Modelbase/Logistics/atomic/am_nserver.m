classdef am_nserver < handle
%% Description
%  processes up to N entities, each with a service time tS.
%  tS is given as parameter or via an input field.
%% Ports
%  inputs: 
%    in       incoming entities
%  outputs: 
%    out      outgoing entities
%    full     "1"/"0"
%    n        current number of entities in server
%% States
%  s:    idle|working|emitting
%  E:    data of processed entities (Nx1)
%  sig:  exit times of processed entities (Nx2, since hyperreals)
%  qOut: list of outgoing entities
%% System Parameters
%  name:    object name
%  N:       capacity
%  tS:      service time as parameter
%  tsField: name of input field containing tS ("": use parameter)
%  tD:      delay time of the emitting state
%  tau:     input delay
%  debug:   model debug level

  properties
    s
    E         % cellarray to hold NaN's and struct
    sig
    qOut      % ordinary array
    name
    N
    tS
    tsField
    tD
    tau
    debug
    epsilon
  end
  
  methods
    function obj = am_nserver(name, N, tS, tsField, tD, tau, debug)
      obj.s = "idle";
      obj.E = num2cell(ones(N,1)*NaN);
      obj.sig = zeros(N,2);    % row = a + b*eps
      obj.sig(:,1) = Inf;
      obj.qOut = [];
      obj.name = name;
      obj.N = N;
      obj.tS = tS;
      obj.tsField = tsField;
      obj.tD = tD;
      obj.tau = tau;
      obj.debug = debug;
      obj.epsilon = get_epsilon();
     end
    
		function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta,", obj.name)
        showState(obj);
      end      

      nE = sum(~cellfun(@ismissing, obj.E));  % number of entities in processing
      obj.sig = obj.sig - e;      % reduce waiting times

      % all confluent events can be handled as internal/external
      isInternal = (obj.s == "emitting") || any(obj.sig(:,1) < obj.epsilon);
      if isInternal 
        if obj.s == "working"
          obj.qOut = extractCompletedEntities(obj);
          obj.s = "emitting";
        elseif obj.s == "emitting" && length(obj.qOut) > 1
          obj.qOut = obj.qOut(2:end);
        elseif obj.s == "emitting"  % and nQ == 1
          obj.qOut = [];
          if nE > 0
            obj.s = "working";
          else
            obj.s = "idle";
          end           
        end
      end    % internal event
      
      if ~isempty(x)      % external event
        insertNewEntity(obj, x.in);
        if obj.s == "idle"
          obj.s = "working";
        end
      end   % external event

      if obj.debug
        fprintf("%-8s leaving  delta,", obj.name)
        showState(obj);
      end      
    end
    
    function y = lambda(obj,e,x)
      y = [];     % necessary dummy value for no-op
      if ~isempty(obj.qOut)    % == emitting
        y.out = obj.qOut(1);
      end

      nE = sum(~cellfun(@ismissing, obj.E));  % number of entities in processing
      nQ = length(obj.qOut);      % number of entities to be emitted

      if ~isempty(x) && nE < obj.N
        nE = nE + 1;        % incoming entity will be processed
      end
      if obj.s == "emitting"
        nQ = nQ - 1;
      end
      y.n = nE + nQ;     % could be > N for eps times!

      if nE < obj.N
        y.full = "0";
      else
        y.full = "1";
      end

      if obj.debug
        fprintf("%-8s lambda, ", obj.name);
        if isfield(y, "out")
          fprintf("out=%2d ", y.out);
        end
        if isfield(y, "full")
          fprintf("full=%1s ", y.full);
        end
        if isfield(y, "n")
          fprintf("n=%1d", y.n);
        end
        fprintf("\n")
      end
    end
    
    function t = ta(obj)
      switch obj.s
        case "idle"
          t = [Inf,0];
        case "working"
          t = minHR(obj.sig);
        case "emitting"
          t = obj.tD;
        otherwise
          fprintf("wrong phase %s in %s\n", obj.s, obj.name);
          t = [Inf,0];
      end
    end
    
    %-------------------------------------------------------
    function qOut = extractCompletedEntities(obj)
      % extracts entities that are ready 
      idxs = find(obj.sig(:,1) < obj.epsilon);
      qOut = cell2mat(obj.E(idxs));
      obj.E{idxs} = NaN;
      obj.sig(idxs,1) = Inf;
      obj.sig(idxs,2) = 0;
    end

    function insertNewEntity(obj, in)
      % inserts entity in, if possible
      idxs = find(cellfun(@ismissing, obj.E));   % find free places
      if ~isempty(idxs)
        idx = idxs(1);
        obj.E{idx} = in;
        if obj.tsField == ""
          obj.sig(idx,:) = [obj.tS, 0];
        else
          tS1 = in.(obj.tsField);
          obj.sig(idx,:) = [tS1, 0];
        end
      else
        fprintf("%s, in delta, phase %s - dropping input", obj.name, obj.s)
        if isnumeric(in)
          fprintf(" %2d\n", in)
        elseif isfield(in, "id")
          fprintf(" %2d\n", in.id)
        else
          fprintf("\n")
        end
      end
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%4s ", obj.s)
      fprintf("E=%1d sig=[%4.2f,%4.2f]\n", obj.E, obj.sig(:,1), obj.sig(:,2))
    end
   
  end
end
