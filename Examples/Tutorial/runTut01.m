function runTut01
% makes and runs the model and plots the results
model = "tut01";
tEnd = 6;

model_generator(model);
out = model_simulator(model, tEnd);
plotResults01(out, tEnd)
end
