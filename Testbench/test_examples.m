function tests = test_examples
	tests = functiontests(localfunctions);
end

% Run the models in the Example directory and compare the results 
% with the saved results.
%
% run with TestBrowser app or: run(test_examples)

%% PaperExamples
function test_PaperExamples_compswitch(testCase)
  oldpath = addpath("../Examples/PaperExamples", "TestExamples/PaperExamples");
	act_out = testCompswitch(false);
	load("testCompswitch_out.mat");
	verifyEqual(testCase, act_out, testCompswitch_out)
	path(oldpath);
end
function test_PaperExamples_compswitchA(testCase)
  oldpath = addpath("../Examples/PaperExamples", "TestExamples/PaperExamples");
	act_out = testCompswitchA(false);
	load("testCompswitchA_out.mat");
	verifyEqual(testCase, act_out, testCompswitchA_out)
	path(oldpath);
end
function test_PaperExamples_shiftregister(testCase)
  oldpath = addpath("../Examples/PaperExamples", "TestExamples/PaperExamples");
	act_out = testShiftregister(false);
	load("testShiftregister_out.mat");
	verifyEqual(testCase, act_out, testShiftregister_out)
	path(oldpath);
end
function test_PaperExamples_singleserver(testCase)
  oldpath = addpath("../Examples/PaperExamples", "TestExamples/PaperExamples");
	act_out = testSingleserver(false);
	load("testSingleserver_out.mat");
	verifyEqual(testCase, act_out, testSingleserver_out)
	path(oldpath);
end
function test_PaperExamples_fifo3(testCase)
  oldpath = addpath("../Examples/PaperExamples", "TestExamples/PaperExamples");
	act_out = testFifo3(false);
	load("testFifo3_out.mat");
	verifyEqual(testCase, act_out, testFifo3_out)
	path(oldpath);
end

%% C22
function test_C22_fixFifoA(testCase)
  oldpath = addpath("../Examples/C22", "TestExamples/C22");
	act_out = testFixFifoA(false);
	load("testFixFifoA_out.mat");
	verifyEqual(testCase, act_out, testFixFifoA_out)
	path(oldpath);
end
function test_C22_fixFifoB(testCase)
  oldpath = addpath("../Examples/C22", "TestExamples/C22");
	act_out = testFixFifoB(false);
	load("testFixFifoB_out.mat");
	verifyEqual(testCase, act_out, testFixFifoB_out)
	path(oldpath);
end

%% BigExample
function test_BigExample_productionLine(testCase)
  oldpath = addpath("../Examples/BigExample", "../Examples/BigExample/atomics", ...
                                "TestExamples/BigExample");
	act_out = testProductionLine(false);
	load("testProductionLine_out.mat");
	verifyEqual(testCase, act_out, testProductionLine_out)
	path(oldpath);
end

%% TimeShared
function test_TimeShared_timeShared(testCase)
  oldpath = addpath("../Examples/TimeShared", "TestExamples/TimeShared");
	act_out = testTimeShared(false);
	load("testTimeShared_out.mat");
	verifyEqual(testCase, act_out, testTimeShared_out)
	path(oldpath);
end
