function tests = test_models
	tests = functiontests(localfunctions);
end

%Run the models in the Examplex directory and compare the results 
%with the saved results.
%
%run with: run(test_models)

function test_model1(testCase)

	act_out = model1(10);
	load('model1_out.mat');
	verifyEqual(testCase, act_out, model1_out)
	close all;
end