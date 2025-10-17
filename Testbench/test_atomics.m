function tests = test_atomics
  tests = functiontests(localfunctions);
end

% Run the models in the test directory and compare the results
% with the saved results.
% run with
%   run(test_atomics)

%%%%%%%%%%%%%%%%%%%%Math operations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_add2(testCase)
  addpath("TestAtomics/MathOperations/Add2");
  act_out = testAdd2();
  load("testAdd2_out.mat");
  verifyEqual(testCase, act_out, testAdd2_out)
  rmpath("TestAtomics/MathOperations/Add2");
end
function test_add3(testCase)
  addpath("TestAtomics/MathOperations/Add3");
  act_out = testAdd3();
  load("testAdd3_out.mat");
  verifyEqual(testCase, act_out, testAdd3_out)
  rmpath("TestAtomics/MathOperations/Add3");
end
function test_add4(testCase)
  addpath("TestAtomics/MathOperations/Add4");
  act_out = testAdd4();
  load("testAdd4_out.mat");
  verifyEqual(testCase, act_out, testAdd4_out)
  rmpath("TestAtomics/MathOperations/Add4");
end
function test_add6(testCase)
  addpath("TestAtomics/MathOperations/Add6");
  act_out = testAdd6();
  load("testAdd6_out.mat");
  verifyEqual(testCase, act_out, testAdd6_out)
  rmpath("TestAtomics/MathOperations/Add6");
end
function test_bias(testCase)
  addpath("TestAtomics/MathOperations/Bias");
  act_out = testBias();
  load("testBias_out.mat");
  verifyEqual(testCase, act_out, testBias_out)
  rmpath("TestAtomics/MathOperations/Bias");
end
function test_comparator(testCase)
  addpath("TestAtomics/MathOperations/Comparator");
  act_out = testComparator();
  load("testComparator_out.mat");
  verifyEqual(testCase, act_out, testComparator_out)
  rmpath("TestAtomics/MathOperations/Comparator");
end
function test_gain(testCase)
  addpath("TestAtomics/MathOperations/Gain");
  act_out = testGain();
  load("testGain_out.mat");
  verifyEqual(testCase, act_out, testGain_out)
  rmpath("TestAtomics/MathOperations/Gain");
end
function test_div(testCase)
  addpath("TestAtomics/MathOperations/Div");
  act_out = testDiv();
  load("testDiv_out.mat");
  verifyEqual(testCase, act_out, testDiv_out)
  rmpath("TestAtomics/MathOperations/Div");
end
function test_mult2(testCase)
  addpath("TestAtomics/MathOperations/Mult2");
  act_out = testMult2();
  load("testMult2_out.mat");
  verifyEqual(testCase, act_out, testMult2_out)
  rmpath("TestAtomics/MathOperations/Mult2");
end
function test_mult3(testCase)
  addpath("TestAtomics/MathOperations/Mult3");
  act_out = testMult3();
  load("testMult3_out.mat");
  verifyEqual(testCase, act_out, testMult3_out)
  rmpath("TestAtomics/MathOperations/Mult3");
end
function test_saturation(testCase)
  addpath("TestAtomics/MathOperations/Saturation");
  act_out = testSaturation();
  load("testSaturation_out.mat");
  verifyEqual(testCase, act_out, testSaturation_out)
  rmpath("TestAtomics/MathOperations/Saturation");
end
%%%%%%%%%%%%%%%%%%%%Logistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_batch(testCase)
  addpath("TestAtomics/Logistics/Batch");
  act_out = testBatch();
  load("testBatch_out.mat");
  verifyEqual(testCase, act_out, testBatch_out)
  rmpath("TestAtomics/Logistics/Batch");
end
function test_delay(testCase)
  addpath("TestAtomics/Logistics/Delay");
  act_out = testDelay();
  load("testDelay_out.mat");
  verifyEqual(testCase, act_out, testDelay_out)
  rmpath("TestAtomics/Logistics/Delay");
end
function test_queue(testCase)
  addpath("TestAtomics/Logistics/Queue");
  act_out = testQueue();
  load("testQueue_out.mat");
  verifyEqual(testCase, act_out, testQueue_out)
  rmpath("TestAtomics/Logistics/Queue");
end
function test_server_case1(testCase)
  addpath("TestAtomics/Logistics/Server");
  act_out = testServer(1);
  load("testServer_out1.mat");
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestAtomics/Logistics/Server");
end
function test_server_case2(testCase)
  addpath("TestAtomics/Logistics/Server");
  act_out = testServer(2);
  load("testServer_out2.mat");
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestAtomics/Logistics/Server");
end
function test_unbatch(testCase)
  addpath("TestAtomics/Logistics/Unbatch");
  act_out = testUnbatch();
  load("testUnbatch_out.mat");
  verifyEqual(testCase, act_out, testUnbatch_out)
  rmpath("TestAtomics/Logistics/Unbatch");
end

function test_terminator(testCase)
  addpath("TestAtomics/Logistics/Terminator");
  act_out = testTerminator();
  load("testTerminator_out.mat");
  verifyEqual(testCase, act_out, testTerminator_out)
  rmpath("TestAtomics/Logistics/Terminator");
end
function test_gate(testCase)
  addpath("TestAtomics/Logistics/Gate");
  act_out = testGate();
  load("testGate_out.mat");
  verifyEqual(testCase, act_out, testGate_out)
  rmpath("TestAtomics/Logistics/Gate");
end
%%%%%%%%%%%%%%%%%%%%Routing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_collect3(testCase)
  addpath("TestAtomics/Routing/Collect3");
  act_out = testCollect3();
  load("testCollect3_out.mat");
  verifyEqual(testCase, act_out, testCollect3_out)
  rmpath("TestAtomics/Routing/Collect3");
end
function test_collect4(testCase)
  addpath("TestAtomics/Routing/Collect4");
  act_out = testCollect4();
  load("testCollect4_out.mat");
  verifyEqual(testCase, act_out, testCollect4_out)
  rmpath("TestAtomics/Routing/Collect4");
end
function test_distribute2(testCase)
  addpath("TestAtomics/Routing/Distribute2");
  act_out = testDistribute2();
  load("testDistribute2_out.mat");
  verifyEqual(testCase, act_out, testDistribute2_out)
  rmpath("TestAtomics/Routing/Distribute2");
end
function test_distribute3(testCase)
  addpath("TestAtomics/Routing/Distribute3");
  act_out = testDistribute3();
  load("testDistribute3_out.mat");
  verifyEqual(testCase, act_out, testDistribute3_out)
  rmpath("TestAtomics/Routing/Distribute3");
end
function test_distribute4(testCase)
  addpath("TestAtomics/Routing/Distribute4");
  act_out = testDistribute4();
  load("testDistribute4_out.mat");
  verifyEqual(testCase, act_out, testDistribute4_out)
  rmpath("TestAtomics/Routing/Distribute4");
end
function test_outputswitch(testCase)
  addpath("TestAtomics/Routing/Outputswitch");
  act_out = testOutputswitch();
  load("testOutputswitch_out.mat");
  verifyEqual(testCase, act_out, testOutputswitch_out)
  rmpath("TestAtomics/Routing/Outputswitch");
end
function test_smallestin3(testCase)
  addpath("TestAtomics/Routing/Smallestin3");
  act_out = testSmallestin3();
  load("testSmallestin3_out.mat");
  verifyEqual(testCase, act_out, testSmallestin3_out)
  rmpath("TestAtomics/Routing/Smallestin3");
end
function test_smallestin4(testCase)
  addpath("TestAtomics/Routing/Smallestin4");
  act_out = testSmallestin4();
  load("testSmallestin4_out.mat");
  verifyEqual(testCase, act_out, testSmallestin4_out)
  rmpath("TestAtomics/Routing/Smallestin4");
end

%%%%%%%%%%%%%%%%%%%%Sinks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_toworkspace(testCase)
  addpath("TestAtomics/Sinks/Toworkspace");
  act_out = testToworkspace();
  load("testToworkspace_out.mat");
  verifyEqual(testCase, act_out, testToworkspace_out)
  rmpath("TestAtomics/Sinks/Toworkspace");
end

%%%%%%%%%%%%%%%%%%%%Sources%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_fromworkspace(testCase)
  addpath("TestAtomics/Sources/Fromworkspace");
  act_out = testFromworkspace();
  load("testFromworkspace_out.mat");
  verifyEqual(testCase, act_out, testFromworkspace_out)
  rmpath("TestAtomics/Sources/Fromworkspace");
end
function test_generator(testCase)
  addpath("TestAtomics/Sources/Generator");
  act_out = testGenerator();
  load("testGenerator_out.mat");
  verifyEqual(testCase, act_out, testGenerator_out)
  rmpath("TestAtomics/Sources/Generator");
end
function test_vectorgen(testCase)
  addpath("TestAtomics/Sources/Vectorgen");
  act_out = testVectorgen();
  load("testVectorgen_out.mat");
  verifyEqual(testCase, act_out, testVectorgen_out)
  rmpath("TestAtomics/Sources/Vectorgen");
end
function test_bingenerator(testCase)
  addpath("TestAtomics/Sources/Bingenerator");
  act_out = testBingenerator();
  load("testBingenerator_out.mat");
  verifyEqual(testCase, act_out, testBingenerator_out)
  rmpath("TestAtomics/Sources/Bingenerator");
end
function test_const(testCase)
  addpath("TestAtomics/Sources/Const");
  act_out = testConst();
  load("testConst_out.mat");
  verifyEqual(testCase, act_out, testConst_out)
  rmpath("TestAtomics/Sources/Const");
end
function test_enabledgenerator(testCase)
  addpath("TestAtomics/Sources/EnabledGenerator");
  act_out = testEnabledGenerator();
  load("testEnabledGenerator_out.mat");
  verifyEqual(testCase, act_out, testEnabledGenerator_out)
  rmpath("TestAtomics/Sources/EnabledGenerator");
end

%%%%%%%%%%%%%%%%%%%%QSS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_hIntegrator(testCase)
  addpath("TestAtomics/Qss/Hintegrator");
  act_out = testhIntegrator();
  load("testhIntegrator_out.mat");
  verifyEqual(testCase, act_out, testhIntegrator_out)
  rmpath("TestAtomics/Qss/Hintegrator");
end

%%%%%%%%%%%%%%%%%%%%Digital%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Converter
function am_bin8_to_dec_test(testCase)
  addpath("TestAtomics/Digital/Converter/Bin8_to_dec");
  act_out = test_am_bin8_to_dec();
  load("test_am_bin8_to_dec_out.mat");
  verifyEqual(testCase, act_out, test_am_bin8_to_dec_out)
  rmpath("TestAtomics/Digital/Converter/Bin8_to_dec");
end
function am_dec_to_bin8_test(testCase)
  addpath("TestAtomics/Digital/Converter/Dec_to_bin8");
  act_out = test_am_dec_to_bin8();
  load("test_am_dec_to_bin8_out.mat");
  verifyEqual(testCase, act_out, test_am_dec_to_bin8_out)
  rmpath("TestAtomics/Digital/Converter/Dec_to_bin8");
end
function am_bin_to_double_test(testCase)
  addpath("TestAtomics/Digital/Converter/Bin_to_double");
  act_out = test_am_bin_to_double();
  load("test_am_bin_to_double_out.mat");
  verifyEqual(testCase, act_out, test_am_bin_to_double_out)
  rmpath("TestAtomics/Digital/Converter/Bin_to_double");
end

%%Logic
function am_nand2_test(testCase)
  addpath("TestAtomics/Digital/Logic/Nand2");
  act_out = test_am_nand2();
  load("test_am_nand2_out.mat");
  verifyEqual(testCase, act_out, test_am_nand2_out)
  rmpath("TestAtomics/Digital/Logic/Nand2");
end
function am_nand3_test(testCase)
  addpath("TestAtomics/Digital/Logic/Nand3");
  act_out = test_am_nand3();
  load("test_am_nand3_out.mat");
  verifyEqual(testCase, act_out, test_am_nand3_out)
  rmpath("TestAtomics/Digital/Logic/Nand3");
end
function am_nand4_test(testCase)
  addpath("TestAtomics/Digital/Logic/Nand4");
  act_out = test_am_nand4();
  load("test_am_nand4_out.mat");
  verifyEqual(testCase, act_out, test_am_nand4_out)
  rmpath("TestAtomics/Digital/Logic/Nand4");
end
function am_notgate_test(testCase)
  addpath("TestAtomics/Digital/Logic/Not");
  act_out = test_am_not();
  load("test_am_not_out.mat");
  verifyEqual(testCase, act_out, test_am_not_out)
  rmpath("TestAtomics/Digital/Logic/Not");
end
function am_or2_test(testCase)
  addpath("TestAtomics/Digital/Logic/Or2");
  act_out = test_am_or2();
  load("test_am_or2_out.mat");
  verifyEqual(testCase, act_out, test_am_or2_out)
  rmpath("TestAtomics/Digital/Logic/Or2");
end

%Model by Model verification
function MMV_not_test(testCase)
  addpath("TestBlocklib/Digital/Logic/NotC");
  addpath("TestAtomics/Digital/Logic/Not");
  out_cm = test_cm_not();
  out_am = test_am_not();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestBlocklib/Digital/Logic/NotC");
  rmpath("TestAtomics/Digital/Logic/Not");
end
function MMV_or2_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Or2C");
  addpath("TestAtomics/Digital/Logic/Or2");
  out_cm = test_cm_or2();
  out_am = test_am_or2();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestBlocklib/Digital/Logic/Or2C");
  rmpath("TestAtomics/Digital/Logic/Or2");
end

%%Flip Flops
function am_jk_flip_flop_test(testCase)
  addpath("TestAtomics/Digital/FlipFlops/JKFF");
  act_out = test_am_jk_flip_flop();
  load("test_am_jk_flip_flop_out.mat");
  verifyEqual(testCase, act_out, test_am_jk_flip_flop_out)
  rmpath("TestAtomics/Digital/FlipFlops/JKFF");
end

%Model by Model verification

%%%%%%%%%%%%%%%%%%%%Statistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_utilization(testCase)
  addpath("TestAtomics/Statistics/Utilization");
  act_out = testUtilization();
  load("testUtilization_out.mat");
  verifyEqual(testCase, act_out, testUtilization_out)
  rmpath("TestAtomics/Statistics/Utilization");
end
function test_getmax(testCase)
  addpath("TestAtomics/Statistics/Getmax");
  act_out = testGetmax();
  load("testGetmax_out.mat");
  verifyEqual(testCase, act_out, testGetmax_out)
  rmpath("TestAtomics/Statistics/Getmax");
end
%%%%%%%%%%%%%%%%%%%%Utilities%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function test_getDescription_case1(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(1);
  load("testGetDescription_out1.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case2(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(2);
  load("testGetDescription_out2.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case3(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(3);
  load("testGetDescription_out3.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case4(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(4);
  load("testGetDescription_out4.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case5(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(5);
  load("testGetDescription_out5.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case6(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(6);
  load("testGetDescription_out6.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case7(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(7);
  load("testGetDescription_out7.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case8(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(8);
  load("testGetDescription_out8.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case9(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(9);
  load("testGetDescription_out9.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case10(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(10);
  load("testGetDescription_out10.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_getDescription_case11(testCase)
  addpath("TestAtomics/Utilities/GetDescription");
  act_out = testGetDescription(11);
  load("testGetDescription_out11.mat");
  verifyEqual(testCase, act_out, testGetDescription_out)
  rmpath("TestAtomics/Utilities/GetDescription");
end
function test_minHR_case1(testCase)
  addpath("TestAtomics/Utilities/MinHR");
  act_out = testMinHR(1);
  load("testMinHR_out1.mat");
  verifyEqual(testCase, act_out, testMinHR_out)
  rmpath("TestAtomics/Utilities/MinHR");
end
function test_minHR_case2(testCase)
  addpath("TestAtomics/Utilities/MinHR");
  act_out = testMinHR(2);
  load("testMinHR_out2.mat");
  verifyEqual(testCase, act_out, testMinHR_out)
  rmpath("TestAtomics/Utilities/MinHR");
end
function test_minHR_case3(testCase)
  addpath("TestAtomics/Utilities/MinHR");
  act_out = testMinHR(3);
  load("testMinHR_out3.mat");
  verifyEqual(testCase, act_out, testMinHR_out)
  rmpath("TestAtomics/Utilities/MinHR");
end
