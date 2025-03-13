classdef am_initrng < handle
  %% Description
  %  Initializes the random generator.
  %% Ports
  %  inputs:
  %  outputs:
  %% States
  %% System Parameters
  %  name:     object name
  %  useSeed:  if true, the random generator is initialized
  %  seed:     seed to initialize the random generator
  %  debug:    flag to enable debug information

  properties
    name
    useSeed
    seed
    debug
  end

  methods
    function obj = am_initrng(name, useSeed, seed, debug)
      obj.name = name;
      obj.debug = debug;
      if useSeed
        rng(seed);
      end
    end

    function delta(obj,e,x)
    end

    function y = lambda(obj,e,x)
    end

    function t = ta(obj)
      t = [inf, 0];
    end
  end
end
