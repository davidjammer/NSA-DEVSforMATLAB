classdef am_generatorDist < handle
  %% Description
  %  generates entities with distribution-dependent interarrival times and
  %  increasing id's. The first entity is created at t=0 or after a first waiting
  % time. When generating multiple entities at t=0 using "Constant" [0], the
  % internal time delay must be adjusted.
  %% Ports
  %  inputs:  none
  %  outputs:
  %    out    generated entities
  %% States
  %  s:       running
  %  id:      number of next entity generated
  %  sig:     time advance until next entity generation
  %  epsilon: accuracy of real number comparisons
  %% System Parameters
  %  name:     object name
  %  distName: distribution name (Constant/Exponential/Triangular)
  %  distPara: distribution parameters
  %            Constant     [a]      constant value
  %            Exponential  [a]      mean value
  %            Triangular   [a,m,b]  [min, most, max]
  %  n0:       id of first entity
  %  nG:       total number of entities to create
  %  nT0:      flag for generation of 1st entity at t=0
  %  tD:       delay between entities, if "Constant", [0] & nG > 1                                       ***
  %  debug:    flag to enable debug information

  % 2025/09/27 TP

  properties
    s
    id
    sig
    epsilon
    name
    distName
    distPara
    n0
    nG
    nT0
    tD
    debug
  end

  methods
    function obj = am_generatorDist(name, distName, distPara, n0, nG,...
        nT0, tD, debug)

      obj.name     = name;
      obj.distName = distName;
      obj.distPara = distPara;
      obj.n0       = n0;
      obj.nG       = nG;
      obj.nT0      = nT0;
      obj.tD       = tD;
      obj.debug = debug;

      obj.s = "running";
      obj.id = n0;
      obj.epsilon = get_epsilon();

      % Check input para compliance
      try
        switch obj.distName
          case {"Constant", "Exponential"}
            assert(isscalar(obj.distPara));
          case "Triangular"
            assert(numel(obj.distPara)==3);
          otherwise
            error('Name of distribution is unknown.')
        end
      catch
        error(obj.name + ": Distribution parameters do not match.")
      end

      if distName=="Constant" && distPara == 0 && nG > 1 && isequal(tD,[0,1])
        warning("Multiple entity generation at t=0. Is tD adjusted?")
      end

      % Init time advance until next entity generation
      if (obj.nT0)
        obj.sig = 0;           % gen 1st entity at t=0
        obj.nT0 = false;
      else
        obj.sig = distributionFcn(obj.distName, obj.distPara);
      end
    end

    %%
    function delta(obj,e,x)
      tr = ta(obj);
      if abs(e(1) - tr(1)) <= obj.epsilon %TRUE, if internal ev
        obj.id  = obj.id + 1;
        obj.sig = distributionFcn(obj.distName, obj.distPara);
      end
      if obj.debug
        fprintf("%-8s leaving delta:\n id= %2d, sig= %f\n", ...
          obj.name, obj.id, obj.sig)
      end
    end

    %%
    function y = lambda(obj,e,x)
      tr = ta(obj);
      if abs(e(1) - tr(1)) <= obj.epsilon %TRUE for internal ev
        y.out = obj.id;
      end
      if obj.debug
        fprintf("%-8s lambda\n  out: %2d\n", obj.name, y.out)
      end
    end

    %%
    function t = ta(obj)
      if obj.id - obj.n0 < obj.nG
        if obj.sig == 0 && obj.id == obj.n0
          t = [0, 0];    %1st entity at T=0
        elseif obj.sig == 0 && obj.id > obj.n0
          t = obj.tD;    %more than 1 entity at T=0 ->simultaneous ev
        else
          t = [obj.sig, 0];
        end
      else
        t = [inf, 0];
      end
    end

  end %methods
end %classdef
