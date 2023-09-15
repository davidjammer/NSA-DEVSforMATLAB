function out = model_simulator(model, tEnd, clearFlag, displayFlag)
% runs a model
% assumes previous call of model_generator
% parameters
%   model       name of model to run
%   tEnd        end time of simulation
%   clearFlag   true (default) -> out directory is removed

if nargin == 2
  clearFlag = true;
  displayFlag = false;
end

global simout
simout = [];     % delete values from previous runs

addpath(model);
N0 = eval("build_" + model +"(""model"")");
rmpath(model);

root = rootcoordinator("root", 0, tEnd, N0, 0, displayFlag);
root.sim();

out = simout;


if clearFlag
  rmdir(model, "s")
end
