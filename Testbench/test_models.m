function tests = test_models
  tests = functiontests(localfunctions);
end

%Run the models in the Example directory and compare the results
%with the saved results.
%
% run with: run(test_models)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%Modelbase%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%Math operations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_add2(testCase)
  addpath("TestCases/Modelbase/MathOperations/Add2");
  act_out = testAdd2();
  load('testAdd2_out.mat');
  verifyEqual(testCase, act_out, testAdd2_out)
  rmpath("TestCases/Modelbase/MathOperations/Add2");
end
function test_add3(testCase)
  addpath("TestCases/Modelbase/MathOperations/Add3");
  act_out = testAdd3();
  load('testAdd3_out.mat');
  verifyEqual(testCase, act_out, testAdd3_out)
  rmpath("TestCases/Modelbase/MathOperations/Add3");
end
function test_add4(testCase)
  addpath("TestCases/Modelbase/MathOperations/Add4");
  act_out = testAdd4();
  load('testAdd4_out.mat');
  verifyEqual(testCase, act_out, testAdd4_out)
  rmpath("TestCases/Modelbase/MathOperations/Add4");
end
function test_add6(testCase)
  addpath("TestCases/Modelbase/MathOperations/Add6");
  act_out = testAdd6();
  load('testAdd6_out.mat');
  verifyEqual(testCase, act_out, testAdd6_out)
  rmpath("TestCases/Modelbase/MathOperations/Add6");
end
function test_bias(testCase)
  addpath("TestCases/Modelbase/MathOperations/Bias");
  act_out = testBias();
  load('testBias_out.mat');
  verifyEqual(testCase, act_out, testBias_out)
  rmpath("TestCases/Modelbase/MathOperations/Bias");
end
function test_comparator(testCase)
  addpath("TestCases/Modelbase/MathOperations/Comparator");
  act_out = testComparator();
  load('testComparator_out.mat');
  verifyEqual(testCase, act_out, testComparator_out)
  rmpath("TestCases/Modelbase/MathOperations/Comparator");
end
function test_Gain(testCase)
  addpath("TestCases/Modelbase/MathOperations/Gain");
  act_out = testGain();
  load('testGain_out.mat');
  verifyEqual(testCase, act_out, testGain_out)
  rmpath("TestCases/Modelbase/MathOperations/Gain");
end
function test_Div(testCase)
  addpath("TestCases/Modelbase/MathOperations/Div");
  act_out = testDiv();
  load('testDiv_out.mat');
  verifyEqual(testCase, act_out, testDiv_out)
  rmpath("TestCases/Modelbase/MathOperations/Div");
end
function test_mult2(testCase)
  addpath("TestCases/Modelbase/MathOperations/Mult2");
  act_out = testMult2();
  load('testMult2_out.mat');
  verifyEqual(testCase, act_out, testMult2_out)
  rmpath("TestCases/Modelbase/MathOperations/Mult2");
end
function test_mult3(testCase)
  addpath("TestCases/Modelbase/MathOperations/Mult3");
  act_out = testMult3();
  load('testMult3_out.mat');
  verifyEqual(testCase, act_out, testMult3_out)
  rmpath("TestCases/Modelbase/MathOperations/Mult3");
end
function test_saturation(testCase)
  addpath("TestCases/Modelbase/MathOperations/Saturation");
  act_out = testSaturation();
  load('testSaturation_out.mat');
  verifyEqual(testCase, act_out, testSaturation_out)
  rmpath("TestCases/Modelbase/MathOperations/Saturation");
end
%%%%%%%%%%%%%%%%%%%%Logistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_batch(testCase)
  addpath("TestCases/Modelbase/Logistics/Batch");
  act_out = testBatch();
  load('testBatch_out.mat');
  verifyEqual(testCase, act_out, testBatch_out)
  rmpath("TestCases/Modelbase/Logistics/Batch");
end
function test_delay(testCase)
  addpath("TestCases/Modelbase/Logistics/Delay");
  act_out = testDelay();
  load('testDelay_out.mat');
  verifyEqual(testCase, act_out, testDelay_out)
  rmpath("TestCases/Modelbase/Logistics/Delay");
end
function test_queue(testCase)
  addpath("TestCases/Modelbase/Logistics/Queue");
  act_out = testQueue();
  load('testQueue_out.mat');
  verifyEqual(testCase, act_out, testQueue_out)
  rmpath("TestCases/Modelbase/Logistics/Queue");
end
function test_server_case1(testCase)
  addpath("TestCases/Modelbase/Logistics/Server");
  act_out = testServer(1);
  load('testServer_out1.mat');
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestCases/Modelbase/Logistics/Server");
end
function test_server_case2(testCase)
  addpath("TestCases/Modelbase/Logistics/Server");
  act_out = testServer(2);
  load('testServer_out2.mat');
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestCases/Modelbase/Logistics/Server");
end
function test_unbatch(testCase)
  addpath("TestCases/Modelbase/Logistics/Unbatch");
  act_out = testUnbatch();
  load('testUnbatch_out.mat');
  verifyEqual(testCase, act_out, testUnbatch_out)
  rmpath("TestCases/Modelbase/Logistics/Unbatch");
end

function test_terminator(testCase)
  addpath("TestCases/Modelbase/Logistics/Terminator");
  act_out = testTerminator();
  load('testTerminator_out.mat');
  verifyEqual(testCase, act_out, testTerminator_out)
  rmpath("TestCases/Modelbase/Logistics/Terminator");
end
function test_gate(testCase)
  addpath("TestCases/Modelbase/Logistics/Gate");
  act_out = testGate();
  load('testGate_out.mat');
  verifyEqual(testCase, act_out, testGate_out)
  rmpath("TestCases/Modelbase/Logistics/Gate");
end
%%%%%%%%%%%%%%%%%%%%Routing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_combine3(testCase)
  addpath("TestCases/Modelbase/Routing/Combine3");
  act_out = testCombine3();
  load('testCombine3_out.mat');
  verifyEqual(testCase, act_out, testCombine3_out)
  rmpath("TestCases/Modelbase/Routing/Combine3");
end
function test_combine4(testCase)
  addpath("TestCases/Modelbase/Routing/Combine4");
  act_out = testCombine4();
  load('testCombine4_out.mat');
  verifyEqual(testCase, act_out, testCombine4_out)
  rmpath("TestCases/Modelbase/Routing/Combine4");
end
function test_distribute2(testCase)
  addpath("TestCases/Modelbase/Routing/Distribute2");
  act_out = testDistribute2();
  load('testDistribute2_out.mat');
  verifyEqual(testCase, act_out, testDistribute2_out)
  rmpath("TestCases/Modelbase/Routing/Distribute2");
end
function test_distribute3(testCase)
  addpath("TestCases/Modelbase/Routing/Distribute3");
  act_out = testDistribute3();
  load('testDistribute3_out.mat');
  verifyEqual(testCase, act_out, testDistribute3_out)
  rmpath("TestCases/Modelbase/Routing/Distribute3");
end
function test_distribute4(testCase)
  addpath("TestCases/Modelbase/Routing/Distribute4");
  act_out = testDistribute4();
  load('testDistribute4_out.mat');
  verifyEqual(testCase, act_out, testDistribute4_out)
  rmpath("TestCases/Modelbase/Routing/Distribute4");
end
function test_outputswitch(testCase)
  addpath("TestCases/Modelbase/Routing/Outputswitch");
  act_out = testOutputswitch();
  load('testOutputswitch_out.mat');
  verifyEqual(testCase, act_out, testOutputswitch_out)
  rmpath("TestCases/Modelbase/Routing/Outputswitch");
end
function test_smallestin3(testCase)
  addpath("TestCases/Modelbase/Routing/Smallestin3");
  act_out = testSmallestin3();
  load('testSmallestin3_out.mat');
  verifyEqual(testCase, act_out, testSmallestin3_out)
  rmpath("TestCases/Modelbase/Routing/Smallestin3");
end
function test_smallestin4(testCase)
  addpath("TestCases/Modelbase/Routing/Smallestin4");
  act_out = testSmallestin4();
  load('testSmallestin4_out.mat');
  verifyEqual(testCase, act_out, testSmallestin4_out)
  rmpath("TestCases/Modelbase/Routing/Smallestin4");
end

%%%%%%%%%%%%%%%%%%%%Sinks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_toworkspace(testCase)
  addpath("TestCases/Modelbase/Sinks/Toworkspace");
  act_out = testToworkspace();
  load('testToworkspace_out.mat');
  verifyEqual(testCase, act_out, testToworkspace_out)
  rmpath("TestCases/Modelbase/Sinks/Toworkspace");
end

%%%%%%%%%%%%%%%%%%%%Sources%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_fromworkspace(testCase)
  addpath("TestCases/Modelbase/Sources/Fromworkspace");
  act_out = testFromworkspace();
  load('testFromworkspace_out.mat');
  verifyEqual(testCase, act_out, testFromworkspace_out)
  rmpath("TestCases/Modelbase/Sources/Fromworkspace");
end
function test_Generator(testCase)
  addpath("TestCases/Modelbase/Sources/Generator");
  act_out = testGenerator();
  load('testGenerator_out.mat');
  verifyEqual(testCase, act_out, testGenerator_out)
  rmpath("TestCases/Modelbase/Sources/Generator");
end
function test_vectorgen(testCase)
  addpath("TestCases/Modelbase/Sources/Vectorgen");
  act_out = testVectorgen();
  load('testVectorgen_out.mat');
  verifyEqual(testCase, act_out, testVectorgen_out)
  rmpath("TestCases/Modelbase/Sources/Vectorgen");
end
function test_bingenerator(testCase)
  addpath("TestCases/Modelbase/Sources/Bingenerator");
  act_out = testBingenerator();
  load('testBingenerator_out.mat');
  verifyEqual(testCase, act_out, testBingenerator_out)
  rmpath("TestCases/Modelbase/Sources/Bingenerator");
end
function test_Const(testCase)
  addpath("TestCases/Modelbase/Sources/Const");
  act_out = testConst();
  load('testConst_out.mat');
  verifyEqual(testCase, act_out, testConst_out)
  rmpath("TestCases/Modelbase/Sources/Const");
end
function test_enabledgenerator(testCase)
  addpath("TestCases/Modelbase/Sources/EnabledGenerator");
  act_out = testEnabledGenerator();
  load('testEnabledGenerator_out.mat');
  verifyEqual(testCase, act_out, testEnabledGenerator_out)
  rmpath("TestCases/Modelbase/Sources/EnabledGenerator");
end

%%%%%%%%%%%%%%%%%%%%QSS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_hIntegrator(testCase)
  addpath("TestCases/Modelbase/Qss/Hintegrator");
  act_out = testhIntegrator();
  load('testhIntegrator_out.mat');
  verifyEqual(testCase, act_out, testhIntegrator_out)
  rmpath("TestCases/Modelbase/Qss/Hintegrator");
end

%%%%%%%%%%%%%%%%%%%%Digital%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Converter
function am_bin8_to_dec_test(testCase)
  addpath("TestCases/Modelbase/Digital/Converter/Bin8_to_dec");
  act_out = test_am_bin8_to_dec();
  load('test_am_bin8_to_dec_out.mat');
  verifyEqual(testCase, act_out, test_am_bin8_to_dec_out)
  rmpath("TestCases/Modelbase/Digital/Converter/Bin8_to_dec");
end
function am_dec_to_bin8_test(testCase)
  addpath("TestCases/Modelbase/Digital/Converter/Dec_to_bin8");
  act_out = test_am_dec_to_bin8();
  load('test_am_dec_to_bin8_out.mat');
  verifyEqual(testCase, act_out, test_am_dec_to_bin8_out)
  rmpath("TestCases/Modelbase/Digital/Converter/Dec_to_bin8");
end
function am_bin_to_double_test(testCase)
  addpath("TestCases/Modelbase/Digital/Converter/Bin_to_double");
  act_out = test_am_bin_to_double();
  load('test_am_bin_to_double_out.mat');
  verifyEqual(testCase, act_out, test_am_bin_to_double_out)
  rmpath("TestCases/Modelbase/Digital/Converter/Bin_to_double");
end

%%Logic
function am_nand2_test(testCase)
  addpath("TestCases/Modelbase/Digital/Logic/Nand2");
  act_out = test_am_nand2();
  load('test_am_nand2_out.mat');
  verifyEqual(testCase, act_out, test_am_nand2_out)
  rmpath("TestCases/Modelbase/Digital/Logic/Nand2");
end
function am_nand3_test(testCase)
  addpath("TestCases/Modelbase/Digital/Logic/Nand3");
  act_out = test_am_nand3();
  load('test_am_nand3_out.mat');
  verifyEqual(testCase, act_out, test_am_nand3_out)
  rmpath("TestCases/Modelbase/Digital/Logic/Nand3");
end
function am_nand4_test(testCase)
  addpath("TestCases/Modelbase/Digital/Logic/Nand4");
  act_out = test_am_nand4();
  load('test_am_nand4_out.mat');
  verifyEqual(testCase, act_out, test_am_nand4_out)
  rmpath("TestCases/Modelbase/Digital/Logic/Nand4");
end
function am_notgate_test(testCase)
  addpath("TestCases/Modelbase/Digital/Logic/Not");
  act_out = test_am_not();
  load('test_am_not_out.mat');
  verifyEqual(testCase, act_out, test_am_not_out)
  rmpath("TestCases/Modelbase/Digital/Logic/Not");
end
function am_or2_test(testCase)
  addpath("TestCases/Modelbase/Digital/Logic/Or2");
  act_out = test_am_or2();
  load('test_am_or2_out.mat');
  verifyEqual(testCase, act_out, test_am_or2_out)
  rmpath("TestCases/Modelbase/Digital/Logic/Or2");
end

%Model by Model verification
function MMV_not_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/NotC");
  addpath("TestCases/Modelbase/Digital/Logic/Not");
  out_cm = test_cm_not();
  out_am = test_am_not();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestCases/Blocklib/Digital/Logic/NotC");
  rmpath("TestCases/Modelbase/Digital/Logic/Not");
end
function MMV_or2_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Or2C");
  addpath("TestCases/Modelbase/Digital/Logic/Or2");
  out_cm = test_cm_or2();
  out_am = test_am_or2();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestCases/Blocklib/Digital/Logic/Or2C");
  rmpath("TestCases/Modelbase/Digital/Logic/Or2");
end

%%Flip Flops
function am_jk_flip_flop_test(testCase)
  addpath("TestCases/Modelbase/Digital/FlipFlops/JKFF");
  act_out = test_am_jk_flip_flop();
  load('test_am_jk_flip_flop_out.mat');
  verifyEqual(testCase, act_out, test_am_jk_flip_flop_out)
  rmpath("TestCases/Modelbase/Digital/FlipFlops/JKFF");
end

%Model by Model verification

%%%%%%%%%%%%%%%%%%%%Statistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_utilization(testCase)
  addpath("TestCases/Modelbase/Statistics/Utilization");
  act_out = testUtilization();
  load('testUtilization_out.mat');
  verifyEqual(testCase, act_out, testUtilization_out)
  rmpath("TestCases/Modelbase/Statistics/Utilization");
end
function test_getmax(testCase)
  addpath("TestCases/Modelbase/Statistics/Getmax");
  act_out = testGetmax();
  load('testGetmax_out.mat');
  verifyEqual(testCase, act_out, testGetmax_out)
  rmpath("TestCases/Modelbase/Statistics/Getmax");
end
%%%%%%%%%%%%%%%%%%%%Utilities%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function test_minHR_case1(testCase)
  addpath("TestCases/Modelbase/Utilities/MinHR");
  act_out = testMinHR(1);
  load('testMinHR_out1.mat');
  verifyEqual(testCase, act_out, testMinHR_out)
  rmpath("TestCases/Modelbase/Utilities/MinHR");
end
function test_minHR_case2(testCase)
  addpath("TestCases/Modelbase/Utilities/MinHR");
  act_out = testMinHR(2);
  load('testMinHR_out2.mat');
  verifyEqual(testCase, act_out, testMinHR_out)
  rmpath("TestCases/Modelbase/Utilities/MinHR");
end
function test_minHR_case3(testCase)
  addpath("TestCases/Modelbase/Utilities/MinHR");
  act_out = testMinHR(3);
  load('testMinHR_out3.mat');
  verifyEqual(testCase, act_out, testMinHR_out)
  rmpath("TestCases/Modelbase/Utilities/MinHR");
end


%%%%%%%%%%%%%%%%%%%%Blocklib%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%Logistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_adddata(testCase)
  addpath("TestCases/Blocklib/Logistics/Adddata");
  act_out = testAdddata();
  load('testAdddata_out.mat');
  verifyEqual(testCase, act_out, testAdddata_out)
  rmpath("TestCases/Blocklib/Logistics/Adddata");
end
function test_blocklib_batch(testCase)
  addpath("TestCases/Blocklib/Logistics/Batch");
  act_out = testBatch();
  load('testBatch_out.mat');
  verifyEqual(testCase, act_out, testBatch_out)
  rmpath("TestCases/Blocklib/Logistics/Batch");
end
function test_blocklib_delay(testCase)
  addpath("TestCases/Blocklib/Logistics/Delay");
  act_out = testDelay();
  load('testDelay_out.mat');
  verifyEqual(testCase, act_out, testDelay_out)
  rmpath("TestCases/Blocklib/Logistics/Delay");
end
function test_blocklib_expserver(testCase)
  addpath("TestCases/Blocklib/Logistics/Expserver");
  act_out = testExpserver();
  load('testExpserver_out.mat');
  verifyEqual(testCase, act_out, testExpserver_out)
  rmpath("TestCases/Blocklib/Logistics/Expserver");
end
function test_blocklib_gate(testCase)
  addpath("TestCases/Blocklib/Logistics/Gate");
  act_out = testGate();
  load('testGate_out.mat');
  verifyEqual(testCase, act_out, testGate_out)
  rmpath("TestCases/Blocklib/Logistics/Gate");
end
function test_blocklib_nserver_case1(testCase)
  addpath("TestCases/Blocklib/Logistics/Nserver");
  act_out = testNserver(1);
  load('testNserver_out1.mat');
  verifyEqual(testCase, act_out, testNserver_out)
  rmpath("TestCases/Blocklib/Logistics/Nserver");
end
function test_blocklib_nserver_case2(testCase)
  addpath("TestCases/Blocklib/Logistics/Nserver");
  act_out = testNserver(2);
  load('testNserver_out2.mat');
  verifyEqual(testCase, act_out, testNserver_out)
  rmpath("TestCases/Blocklib/Logistics/Nserver");
end
function test_blocklib_nserver_case3(testCase)
  addpath("TestCases/Blocklib/Logistics/Nserver");
  act_out = testNserver(3);
  load('testNserver_out3.mat');
  verifyEqual(testCase, act_out, testNserver_out)
  rmpath("TestCases/Blocklib/Logistics/Nserver");
end
function test_blocklib_queue(testCase)
  addpath("TestCases/Blocklib/Logistics/Queue");
  act_out = testQueue();
  load('testQueue_out.mat');
  verifyEqual(testCase, act_out, testQueue_out)
  rmpath("TestCases/Blocklib/Logistics/Queue");
end
function test_blocklib_queue1(testCase)
  addpath("TestCases/Blocklib/Logistics/Queue");
  act_out = testQueue1();
  load('testQueue1_out.mat');
  verifyEqual(testCase, act_out, testQueue1_out)
  rmpath("TestCases/Blocklib/Logistics/Queue");
end
function test_blocklib_readdata(testCase)
  addpath("TestCases/Blocklib/Logistics/Readdata");
  act_out = testReaddata();
  load('testReaddata_out.mat');
  verifyEqual(testCase, act_out, testReaddata_out)
  rmpath("TestCases/Blocklib/Logistics/Readdata");
end
function test_blocklib_server_case1(testCase)
  addpath("TestCases/Blocklib/Logistics/Server");
  act_out = testServer(1);
  load('testServer_out1.mat');
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestCases/Blocklib/Logistics/Server");
end
function test_blocklib_server_case2(testCase)
  addpath("TestCases/Blocklib/Logistics/Server");
  act_out = testServer(2);
  load('testServer_out2.mat');
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestCases/Blocklib/Logistics/Server");
end
function test_blocklib_terminator(testCase)
  addpath("TestCases/Blocklib/Logistics/Terminator");
  act_out = testTerminator();
  load('testTerminator_out.mat');
  verifyEqual(testCase, act_out, testTerminator_out)
  rmpath("TestCases/Blocklib/Logistics/Terminator");
end
function test_blocklib_unbatch(testCase)
  addpath("TestCases/Blocklib/Logistics/Unbatch");
  act_out = testUnbatch();
  load('testUnbatch_out.mat');
  verifyEqual(testCase, act_out, testUnbatch_out)
  rmpath("TestCases/Blocklib/Logistics/Unbatch");
end
function test_blocklib_writedata(testCase)
  addpath("TestCases/Blocklib/Logistics/Writedata");
  act_out = testWritedata();
  load('testWritedata_out.mat');
  verifyEqual(testCase, act_out, testWritedata_out)
  rmpath("TestCases/Blocklib/Logistics/Writedata");
end
function test_blocklib_expnserver(testCase)
  addpath("TestCases/Blocklib/Logistics/Expnserver");
  act_out = testExpnserver();
  load('testExpnserver_out.mat');
  verifyEqual(testCase, act_out, testExpnserver_out)
  rmpath("TestCases/Blocklib/Logistics/Expnserver");
end
function test_blocklib_queue_en(testCase)
  addpath("TestCases/Blocklib/Logistics/Queue_en");
  act_out = testQueue_en();
  load('testQueue_en_out.mat');
  verifyEqual(testCase, act_out, testQueue_en_out)
  rmpath("TestCases/Blocklib/Logistics/Queue_en");
end
function test_blocklib_queue_server(testCase)
  addpath("TestCases/Blocklib/Logistics/Queue_server");
  act_out = test_cm_queue_server();
  load('test_cm_queue_server_out.mat');
  verifyEqual(testCase, act_out, test_cm_queue_server_out)
  rmpath("TestCases/Blocklib/Logistics/Queue_server");
end
%%%%%%%%%%%%%%%%%%%%Math operations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_add2(testCase)
  addpath("TestCases/Blocklib/MathOperations/Add2");
  act_out = testAdd2();
  load('testAdd2_out.mat');
  verifyEqual(testCase, act_out, testAdd2_out)
  rmpath("TestCases/Blocklib/MathOperations/Add2");
end
function test_blocklib_add3(testCase)
  addpath("TestCases/Blocklib/MathOperations/Add3");
  act_out = testAdd3();
  load('testAdd3_out.mat');
  verifyEqual(testCase, act_out, testAdd3_out)
  rmpath("TestCases/Blocklib/MathOperations/Add3");
end
function test_blocklib_add4(testCase)
  addpath("TestCases/Blocklib/MathOperations/Add4");
  act_out = testAdd4();
  load('testAdd4_out.mat');
  verifyEqual(testCase, act_out, testAdd4_out)
  rmpath("TestCases/Blocklib/MathOperations/Add4");
end
function test_blocklib_add6(testCase)
  addpath("TestCases/Blocklib/MathOperations/Add6");
  act_out = testAdd6();
  load('testAdd6_out.mat');
  verifyEqual(testCase, act_out, testAdd6_out)
  rmpath("TestCases/Blocklib/MathOperations/Add6");
end
function test_blocklib_addN4(testCase)
  addpath("TestCases/Blocklib/MathOperations/AddN");
  act_out = testAddN4();
  load('testAddN4_out.mat');
  verifyEqual(testCase, act_out, testAddN4_out)
  rmpath("TestCases/Blocklib/MathOperations/AddN");
end
function test_blocklib_addN4a(testCase)
  addpath("TestCases/Blocklib/MathOperations/AddN");
  act_out = testAddN4a();
  load('testAddN4a_out.mat');
  verifyEqual(testCase, act_out, testAddN4a_out)
  rmpath("TestCases/Blocklib/MathOperations/AddN");
end
function test_blocklib_addN(testCase)
  addpath("TestCases/Blocklib/MathOperations/AddN");
  act_out = testAddN();
  load('testAddN_out.mat');
  verifyEqual(testCase, act_out, testAddN_out)
  rmpath("TestCases/Blocklib/MathOperations/AddN");
end
function test_blocklib_comparator(testCase)
  addpath("TestCases/Blocklib/MathOperations/Comparator");
  act_out = testComparator();
  load('testComparator_out.mat');
  verifyEqual(testCase, act_out, testComparator_out)
  rmpath("TestCases/Blocklib/MathOperations/Comparator");
end
function test_blocklib_Gain(testCase)
  addpath("TestCases/Blocklib/MathOperations/Gain");
  act_out = testGain();
  load('testGain_out.mat');
  verifyEqual(testCase, act_out, testGain_out)
  rmpath("TestCases/Blocklib/MathOperations/Gain");
end
function test_blocklib_mult2(testCase)
  addpath("TestCases/Blocklib/MathOperations/Mult2");
  act_out = testMult2();
  load('testMult2_out.mat');
  verifyEqual(testCase, act_out, testMult2_out)
  rmpath("TestCases/Blocklib/MathOperations/Mult2");
end
function test_blocklib_mult3(testCase)
  addpath("TestCases/Blocklib/MathOperations/Mult3");
  act_out = testMult3();
  load('testMult3_out.mat');
  verifyEqual(testCase, act_out, testMult3_out)
  rmpath("TestCases/Blocklib/MathOperations/Mult3");
end
function test_blocklib_saturation(testCase)
  addpath("TestCases/Blocklib/MathOperations/Saturation");
  act_out = testSaturation();
  load('testSaturation_out.mat');
  verifyEqual(testCase, act_out, testSaturation_out)
  rmpath("TestCases/Blocklib/MathOperations/Saturation");
end

%%%%%%%%%%%%%%%%%%%%QSS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_hIntegrator(testCase)
  addpath("TestCases/Blocklib/Qss/Hintegrator");
  act_out = testhIntegrator();
  load('testhIntegrator_out.mat');
  verifyEqual(testCase, act_out, testhIntegrator_out)
  rmpath("TestCases/Blocklib/Qss/Hintegrator");
end

%%%%%%%%%%%%%%%%%%%%Routing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_combine3(testCase)
  addpath("TestCases/Blocklib/Routing/Combine3");
  act_out = testCombine3();
  load('testCombine3_out.mat');
  verifyEqual(testCase, act_out, testCombine3_out)
  rmpath("TestCases/Blocklib/Routing/Combine3");
end
function test_blocklib_combine4(testCase)
  addpath("TestCases/Blocklib/Routing/Combine4");
  act_out = testCombine4();
  load('testCombine4_out.mat');
  verifyEqual(testCase, act_out, testCombine4_out)
  rmpath("TestCases/Blocklib/Routing/Combine4");
end
function test_blocklib_combineN4(testCase)
  addpath("TestCases/Blocklib/Routing/CombineN");
  act_out = testCombineN4();
  load('testCombineN4_out.mat');
  verifyEqual(testCase, act_out, testCombineN4_out)
  rmpath("TestCases/Blocklib/Routing/CombineN");
end
function test_blocklib_combineN(testCase)
  addpath("TestCases/Blocklib/Routing/CombineN");
  act_out = testCombineN();
  load('testCombineN_out.mat');
  verifyEqual(testCase, act_out, testCombineN_out)
  rmpath("TestCases/Blocklib/Routing/CombineN");
end
function test_blocklib_distribute2(testCase)
  addpath("TestCases/Blocklib/Routing/Distribute2");
  act_out = testDistribute2();
  load('testDistribute2_out.mat');
  verifyEqual(testCase, act_out, testDistribute2_out)
  rmpath("TestCases/Blocklib/Routing/Distribute2");
end
function test_blocklib_distribute2a(testCase)
  addpath("TestCases/Blocklib/Routing/Distribute2");
  act_out = testDistribute2a();
  load('testDistribute2a_out.mat');
  verifyEqual(testCase, act_out, testDistribute2a_out)
  rmpath("TestCases/Blocklib/Routing/Distribute2");
end
function test_blocklib_distribute3(testCase)
  addpath("TestCases/Blocklib/Routing/Distribute3");
  act_out = testDistribute3();
  load('testDistribute3_out.mat');
  verifyEqual(testCase, act_out, testDistribute3_out)
  rmpath("TestCases/Blocklib/Routing/Distribute3");
end
function test_blocklib_distribute4(testCase)
  addpath("TestCases/Blocklib/Routing/Distribute4");
  act_out = testDistribute4();
  load('testDistribute4_out.mat');
  verifyEqual(testCase, act_out, testDistribute4_out)
  rmpath("TestCases/Blocklib/Routing/Distribute4");
end
function test_blocklib_distributeN4(testCase)
  addpath("TestCases/Blocklib/Routing/DistributeN");
  act_out = testDistributeN4();
  load('testDistributeN4_out.mat');
  verifyEqual(testCase, act_out, testDistributeN4_out)
  rmpath("TestCases/Blocklib/Routing/DistributeN");
end
function test_blocklib_outputswitch(testCase)
  addpath("TestCases/Blocklib/Routing/Outputswitch");
  act_out = testOutputswitch();
  load('testOutputswitch_out.mat');
  verifyEqual(testCase, act_out, testOutputswitch_out)
  rmpath("TestCases/Blocklib/Routing/Outputswitch");
end
function test_blocklib_smallestin3(testCase)
  addpath("TestCases/Blocklib/Routing/Smallestin3");
  act_out = testSmallestin3();
  load('testSmallestin3_out.mat');
  verifyEqual(testCase, act_out, testSmallestin3_out)
  rmpath("TestCases/Blocklib/Routing/Smallestin3");
end
function test_blocklib_smallestin4(testCase)
  addpath("TestCases/Blocklib/Routing/Smallestin4");
  act_out = testSmallestin4();
  load('testSmallestin4_out.mat');
  verifyEqual(testCase, act_out, testSmallestin4_out)
  rmpath("TestCases/Blocklib/Routing/Smallestin4");
end
function test_blocklib_smallestinN4(testCase)
  addpath("TestCases/Blocklib/Routing/SmallestinN");
  act_out = testSmallestinN4();
  load('testSmallestinN4_out.mat');
  verifyEqual(testCase, act_out, testSmallestinN4_out)
  rmpath("TestCases/Blocklib/Routing/SmallestinN");
end

%%%%%%%%%%%%%%%%%%%%Sinks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_stop(testCase)
  addpath("TestCases/Blocklib/Sinks/Stop");
  act_out = testStop();
  load('testStop_out.mat');
  verifyEqual(testCase, act_out, testStop_out)
  rmpath("TestCases/Blocklib/Sinks/Stop");
end
function test_blocklib_toworkspace(testCase)
  addpath("TestCases/Blocklib/Sinks/Toworkspace");
  act_out = testToworkspace();
  load('testToworkspace_out.mat');
  verifyEqual(testCase, act_out, testToworkspace_out)
  rmpath("TestCases/Blocklib/Sinks/Toworkspace");
end

%%%%%%%%%%%%%%%%%%%%Sources%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_fromworkspace(testCase)
  addpath("TestCases/Blocklib/Sources/Fromworkspace");
  act_out = testFromworkspace();
  load('testFromworkspace_out.mat');
  verifyEqual(testCase, act_out, testFromworkspace_out)
  rmpath("TestCases/Blocklib/Sources/Fromworkspace");
end
function test_blocklib_Generator(testCase)
  addpath("TestCases/Blocklib/Sources/Generator");
  act_out = testGenerator();
  load('testGenerator_out.mat');
  verifyEqual(testCase, act_out, testGenerator_out)
  rmpath("TestCases/Blocklib/Sources/Generator");
end
function test_blocklib_vectorgen(testCase)
  addpath("TestCases/Blocklib/Sources/Vectorgen");
  act_out = testVectorgen();
  load('testVectorgen_out.mat');
  verifyEqual(testCase, act_out, testVectorgen_out)
  rmpath("TestCases/Blocklib/Sources/Vectorgen");
end
function test_blocklib_bingenerator(testCase)
  addpath("TestCases/Blocklib/Sources/Bingenerator");
  act_out = testBingenerator();
  load('testBingenerator_out.mat');
  verifyEqual(testCase, act_out, testBingenerator_out)
  rmpath("TestCases/Blocklib/Sources/Bingenerator");
end
function test_blocklib_Const(testCase)
  addpath("TestCases/Blocklib/Sources/Const");
  act_out = testConst();
  load('testConst_out.mat');
  verifyEqual(testCase, act_out, testConst_out)
  rmpath("TestCases/Blocklib/Sources/Const");
end
function test_blocklib_enabledgenerator(testCase)
  addpath("TestCases/Blocklib/Sources/EnabledGenerator");
  act_out = testEnabledGenerator();
  load('testEnabledGenerator_out.mat');
  verifyEqual(testCase, act_out, testEnabledGenerator_out)
  rmpath("TestCases/Blocklib/Sources/EnabledGenerator");
end

%%%%%%%%%%%%%%%%%%%%Statistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_utilization(testCase)
  addpath("TestCases/Blocklib/Statistics/Utilization");
  act_out = testUtilization();
  load('testUtilization_out.mat');
  verifyEqual(testCase, act_out, testUtilization_out)
  rmpath("TestCases/Blocklib/Statistics/Utilization");
end
function test_blocklib_getmax(testCase)
  addpath("TestCases/Blocklib/Statistics/Getmax");
  act_out = testGetmax();
  load('testGetmax_out.mat');
  verifyEqual(testCase, act_out, testGetmax_out)
  rmpath("TestCases/Blocklib/Statistics/Getmax");
end

%%%%%%%%%%%%%%%%%%%%Digital%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Converter
function am_bin8_to_decblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Converter/Bin8_to_dec");
  act_out = test_am_bin8_to_dec();
  load('test_am_bin8_to_dec_out.mat');
  verifyEqual(testCase, act_out, test_am_bin8_to_dec_out)
  rmpath("TestCases/Blocklib/Digital/Converter/Bin8_to_dec");
end
function am_dec_to_bin8blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Converter/Dec_to_bin8");
  act_out = test_am_dec_to_bin8();
  load('test_am_dec_to_bin8_out.mat');
  verifyEqual(testCase, act_out, test_am_dec_to_bin8_out)
  rmpath("TestCases/Blocklib/Digital/Converter/Dec_to_bin8");
end
function am_bin_to_doubleblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Converter/Bin_to_double");
  act_out = test_am_bin_to_double();
  load('test_am_bin_to_double_out.mat');
  verifyEqual(testCase, act_out, test_am_bin_to_double_out)
  rmpath("TestCases/Blocklib/Digital/Converter/Bin_to_double");
end

%%Logic
function am_nand2blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Nand2");
  act_out = test_am_nand2();
  load('test_am_nand2_out.mat');
  verifyEqual(testCase, act_out, test_am_nand2_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Nand2");
end
function am_nand3blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Nand3");
  act_out = test_am_nand3();
  load('test_am_nand3_out.mat');
  verifyEqual(testCase, act_out, test_am_nand3_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Nand3");
end
function am_nand4blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Nand4");
  act_out = test_am_nand4();
  load('test_am_nand4_out.mat');
  verifyEqual(testCase, act_out, test_am_nand4_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Nand4");
end
function am_notgateblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Not");
  act_out = test_am_not();
  load('test_am_not_out.mat');
  verifyEqual(testCase, act_out, test_am_not_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Not");
end
function am_or2blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Or2");
  act_out = test_am_or2();
  load('test_am_or2_out.mat');
  verifyEqual(testCase, act_out, test_am_or2_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Or2");
end
function cm_and2blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/And2");
  act_out = test_cm_and2();
  load('test_cm_and2_out.mat');
  verifyEqual(testCase, act_out, test_cm_and2_out)
  rmpath("TestCases/Blocklib/Digital/Logic/And2");
end
function cm_notblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/NotC");
  act_out = test_cm_not();
  load('test_cm_not_out.mat');
  verifyEqual(testCase, act_out, test_cm_not_out)
  rmpath("TestCases/Blocklib/Digital/Logic/NotC");
end
function cm_or2blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Or2C");
  act_out = test_cm_or2();
  load('test_cm_or2_out.mat');
  verifyEqual(testCase, act_out, test_cm_or2_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Or2C");
end
function cm_xor2blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Xor2");
  act_out = test_cm_xor2();
  load('test_cm_xor2_out.mat');
  verifyEqual(testCase, act_out, test_cm_xor2_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Xor2");
end
function cm_Mux2to1blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Mux2to1");
  act_out = test_cm_Mux2to1();
  load('test_cm_Mux2to1_out.mat');
  verifyEqual(testCase, act_out, test_cm_Mux2to1_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Mux2to1");
end
function cm_Mux4to1blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Mux4to1");
  act_out = test_cm_Mux4to1();
  load('test_cm_Mux4to1_out.mat');
  verifyEqual(testCase, act_out, test_cm_Mux4to1_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Mux4to1");
end
function cm_halfadderblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Halfadder");
  act_out = test_cm_halfadder();
  load('test_cm_halfadder_out.mat');
  verifyEqual(testCase, act_out, test_cm_halfadder_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Halfadder");
end
function cm_fulladderblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Fulladder");
  act_out = test_cm_fulladder();
  load('test_cm_fulladder_out.mat');
  verifyEqual(testCase, act_out, test_cm_fulladder_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Fulladder");
end
function cm_nand4blocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Nand4C");
  act_out = test_cm_nand4();
  load('test_cm_nand4_out.mat');
  verifyEqual(testCase, act_out, test_cm_nand4_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Nand4C");
end
function cm_rising_edgeblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Rising_edge");
  act_out = test_cm_rising_edge();
  load('test_cm_rising_edge_out.mat');
  verifyEqual(testCase, act_out, test_cm_rising_edge_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Rising_edge");
end
function cm_falling_edgeblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Falling_edge");
  act_out = test_cm_falling_edge();
  load('test_cm_falling_edge_out.mat');
  verifyEqual(testCase, act_out, test_cm_falling_edge_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Falling_edge");
end
function cm_carry_ripple_adder_8bitblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Carry_ripple_adder_8bit");
  act_out = test_cm_carry_ripple_adder_8bit();
  load('test_cm_carry_ripple_adder_8bit_out.mat');
  verifyEqual(testCase, act_out, test_cm_carry_ripple_adder_8bit_out)
  rmpath("TestCases/Blocklib/Digital/Logic/Carry_ripple_adder_8bit");
end
%Model by Model verification
function MMVblocklib_not_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/NotC");
  addpath("TestCases/Blocklib/Digital/Logic/Not");
  out_cm = test_cm_not();
  out_am = test_am_not();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestCases/Blocklib/Digital/Logic/NotC");
  rmpath("TestCases/Blocklib/Digital/Logic/Not");
end
function MMVblocklib_or2_test(testCase)
  addpath("TestCases/Blocklib/Digital/Logic/Or2C");
  addpath("TestCases/Blocklib/Digital/Logic/Or2");
  out_cm = test_cm_or2();
  out_am = test_am_or2();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestCases/Blocklib/Digital/Logic/Or2C");
  rmpath("TestCases/Blocklib/Digital/Logic/Or2");
end

%%Flip Flops
function am_jk_flip_flopblocklib_test(testCase)
  addpath("TestCases/Blocklib/Digital/FlipFlops/JKFF");
  act_out = test_am_jk_flip_flop();
  load('test_am_jk_flip_flop_out.mat');
  verifyEqual(testCase, act_out, test_am_jk_flip_flop_out)
  rmpath("TestCases/Blocklib/Digital/FlipFlops/JKFF");
end
