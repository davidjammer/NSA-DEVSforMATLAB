function tests = test_models
	tests = functiontests(localfunctions);
end

%Run the models in the Examplex directory and compare the results 
%with the saved results.
%
% run with: run(test_models)

function test_model1(testCase)
	act_out = model1(10);
	load('model1_out.mat');
	verifyEqual(testCase, act_out, model1_out)
	close all;
end

function test_model2(testCase)
	act_out = model2(10);
	load('model2_out.mat');
	verifyEqual(testCase, act_out, model2_out)
	close all;
end

function test_model3(testCase)
	act_out = model3(10);
	load('model3_out.mat');
	verifyEqual(testCase, act_out, model3_out)
	close all;
end

function test_model4(testCase)
	act_out = model4(10);
	load('model4_out.mat');
	verifyEqual(testCase, act_out, model4_out)
	close all;
end

function test_model5(testCase)
	act_out = model5(10);
	load('model5_out.mat');
	verifyEqual(testCase, act_out, model5_out)
	close all;
end

function test_model6(testCase)
	act_out = model6(10);
	load('model6_out.mat');
	verifyEqual(testCase, act_out, model6_out)
	close all;
end

function test_testBingenerator(testCase)
	act_out = testBingenerator(14);
	load('testBingenerator_out.mat');
	verifyEqual(testCase, act_out, testBingenerator_out)
	close all;
end

function test_testEnabledGenerator(testCase)
	act_out = testEnabledGenerator();
	load('testEnabledGenerator_out.mat');
	verifyEqual(testCase, act_out, testEnabledGenerator_out)
	close all;
end

function test_testComparator(testCase)
	act_out = testComparator(17);
	load('testComparator_out.mat');
	verifyEqual(testCase, act_out, testComparator_out)
	close all;
end

function test_testAdd2(testCase)
	act_out = testAdd2(11.9);
	load('testAdd2_out.mat');
	verifyEqual(testCase, act_out, testAdd2_out)
	close all;
end

function test_testDistribute3(testCase)
	act_out = testDistribute3(15);
	load('testDistribute3_out.mat');
	verifyEqual(testCase, act_out, testDistribute3_out)
	close all;
end

function test_testCombine3(testCase)
	act_out = testCombine3(15);
	load('testCombine3_out.mat');
	verifyEqual(testCase, act_out, testCombine3_out)
	close all;
end

function test_testNand2(testCase)
	act_out = testNand2();
	load('testNand2_out.mat');
	verifyEqual(testCase, act_out, testNand2_out)
	close all;
end

function test_testDelay(testCase)
	act_out = testDelay();
	load('testDelay_out.mat');
	verifyEqual(testCase, act_out, testDelay_out)
	close all;
end

function test_testUnbatch(testCase)
	act_out = testUnbatch(40);
	load('testUnbatch_out.mat');
	verifyEqual(testCase, act_out, testUnbatch_out)
	close all;
end

function test_testUtilization(testCase)
	act_out = testUtilization(42);
	load('testUtilization_out.mat');
	verifyEqual(testCase, act_out, testUtilization_out)
	close all;
end

%--------------------------------------------------------------------------

function test_example1(testCase)
	act_out = example1(1.5);
	load('example1_out.mat');
	verifyEqual(testCase, act_out, example1_out)
	close all;
end

function test_compswitch1(testCase)
	act_out = compswitch1(2.5);
	load('compswitch1_out.mat');
	verifyEqual(testCase, act_out, compswitch1_out)
	close all;
end

function test_compswitch_case1(testCase)
	act_out = compswitch(17.5, 1);
	load('compswitch_out1.mat');
	verifyEqual(testCase, act_out, compswitch_out1)
	close all;
end

function test_compswitch_case2(testCase)
	act_out = compswitch(17.5, 2);
	load('compswitch_out2.mat');
	verifyEqual(testCase, act_out, compswitch_out2)
	close all;
end

function test_compswitch_case3(testCase)
	act_out = compswitch(17.5, 3);
	load('compswitch_out3.mat');
	verifyEqual(testCase, act_out, compswitch_out3)
	close all;
end

function test_compswitch_case4(testCase)
	act_out = compswitch(17.5, 4);
	load('compswitch_out4.mat');
	verifyEqual(testCase, act_out, compswitch_out4)
	close all;
end

function test_compswitch2(testCase)
	act_out = compswitch2(1.5);
	load('compswitch2_out.mat');
	verifyEqual(testCase, act_out, compswitch2_out)
	close all;
end

function test_compswitch3(testCase)
	act_out = compswitch3(2.5);
	load('compswitch3_out.mat');
	verifyEqual(testCase, act_out, compswitch3_out)
	close all;
end

function test_compswitchCascade1(testCase)
	act_out = compswitchCascade1(17.5);
	load('compswitchCascade1_out.mat');
	verifyEqual(testCase, act_out, compswitchCascade1_out)
	close all;
end

function test_compswitchCascade2(testCase)
	act_out = compswitchCascade2(17.5);
	load('compswitchCascade2_out.mat');
	verifyEqual(testCase, act_out, compswitchCascade2_out)
	close all;
end

function test_singleserver_case1(testCase)
	act_out = singleserver(20, 1);
	load('singleserver_out1.mat');
	verifyEqual(testCase, act_out, singleserver_out1)
	close all;
end

function test_singleserver_case2(testCase)
	act_out = singleserver(20, 2);
	load('singleserver_out2.mat');
	verifyEqual(testCase, act_out, singleserver_out2)
	close all;
end

function test_singleserver_case3(testCase)
	act_out = singleserver(20, 3);
	load('singleserver_out3.mat');
	verifyEqual(testCase, act_out, singleserver_out3)
	close all;
end

function test_singleserver_case4(testCase)
	act_out = singleserver(20, 4);
	load('singleserver_out4.mat');
	verifyEqual(testCase, act_out, singleserver_out4)
	close all;
end

function test_singleserver_case5(testCase)
	act_out = singleserver(20, 5);
	load('singleserver_out5.mat');
	verifyEqual(testCase, act_out, singleserver_out5)
	close all;
end

function test_singleserver1_case1(testCase)
	act_out = singleserver1(4.5,false,1);
	load('singleserver1_out1.mat');
	verifyEqual(testCase, act_out, singleserver1_out1)
	close all;
end

function test_singleserver1_case2(testCase)
	act_out = singleserver1(4.5,false,2);
	load('singleserver1_out2.mat');
	verifyEqual(testCase, act_out, singleserver1_out2)
	close all;
end

function test_testQueueServerCM(testCase)
	act_out = testQueueServerCM();
	load('testQueueServerCM_out.mat');
	verifyEqual(testCase, act_out, testQueueServerCM_out)
	close all;
end

function test_fifo3A(testCase)
	act_out = fifo3A(38);
	load('fifo3A_out.mat');
	verifyEqual(testCase, act_out, fifo3A_out)
	close all;
end

function test_fifo3B(testCase)
	act_out = fifo3B(38);
	load('fifo3B_out.mat');
	verifyEqual(testCase, act_out, fifo3B_out)
	close all;
end
