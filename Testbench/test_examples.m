function tests = test_examples
	tests = functiontests(localfunctions);
end

% Run the models in the Example directory and compare the results 
% with the saved results.
% run with:
%    run(test_examples)

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
	verifyEqual(testCase, act_out, testProductionLine_out, RelTol=1e-14)
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

%% Tutorial
function test_Tutorial_tut01(testCase)
  oldpath = addpath("../Examples/Tutorial", "TestExamples/Tutorial");
	act_out = testTut01(false);
	load("testTut01_out.mat");
	verifyEqual(testCase, act_out, testTut01_out)
	path(oldpath);
end
function test_Tutorial_tut02(testCase)
  oldpath = addpath("../Examples/Tutorial", "TestExamples/Tutorial");
	act_out = testTut02(false);
	load("testTut02_out.mat");
	verifyEqual(testCase, act_out, testTut02_out)
	path(oldpath);
end
function test_Tutorial_tut03(testCase)
  oldpath = addpath("../Examples/Tutorial", "TestExamples/Tutorial");
	act_out = testTut03(false);
	load("testTut03_out.mat");
	verifyEqual(testCase, act_out, testTut03_out)
	path(oldpath);
end
function test_Tutorial_tut04(testCase)
  oldpath = addpath("../Examples/Tutorial", "TestExamples/Tutorial");
	act_out = testTut04(false);
	load("testTut04_out.mat");
	verifyEqual(testCase, act_out, testTut04_out)
	path(oldpath);
end
function test_Tutorial_tut05(testCase)
  oldpath = addpath("../Examples/Tutorial", "TestExamples/Tutorial");
	act_out = testTut05(false);
	load("testTut05_out.mat");
	verifyEqual(testCase, act_out, testTut05_out)
	path(oldpath);
end
function test_Tutorial_tut06(testCase)
  oldpath = addpath("../Examples/Tutorial", "TestExamples/Tutorial");
	act_out = testTut06(false);
	load("testTut06_out.mat");
	verifyEqual(testCase, act_out, testTut06_out)
	path(oldpath);
end
function test_Tutorial_tut07(testCase)
  oldpath = addpath("../Examples/Tutorial", "TestExamples/Tutorial");
	act_out = testTut07(false);
	load("testTut07_out.mat");
	verifyEqual(testCase, act_out, testTut07_out)
	path(oldpath);
end
