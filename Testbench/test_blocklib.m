function tests = test_blocklib
  tests = functiontests(localfunctions);
end

% Run the models in the test directory and compare the results
% with the saved results.
% run with
%   run(test_blocklib)

%%%%%%%%%%%%%%%%%%%%Logistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_adddata(testCase)
  addpath("TestBlocklib/Logistics/Adddata");
  act_out = testAdddata();
  load("testAdddata_out.mat");
  verifyEqual(testCase, act_out, testAdddata_out)
  rmpath("TestBlocklib/Logistics/Adddata");
end
function test_blocklib_batch(testCase)
  addpath("TestBlocklib/Logistics/Batch");
  act_out = testBatch();
  load("testBatch_out.mat");
  verifyEqual(testCase, act_out, testBatch_out)
  rmpath("TestBlocklib/Logistics/Batch");
end
function test_blocklib_delay(testCase)
  addpath("TestBlocklib/Logistics/Delay");
  act_out = testDelay();
  load("testDelay_out.mat");
  verifyEqual(testCase, act_out, testDelay_out)
  rmpath("TestBlocklib/Logistics/Delay");
end
function test_blocklib_expserver(testCase)
  addpath("TestBlocklib/Logistics/Expserver");
  act_out = testExpserver();
  load("testExpserver_out.mat");
  verifyEqual(testCase, act_out, testExpserver_out)
  rmpath("TestBlocklib/Logistics/Expserver");
end
function test_blocklib_gate(testCase)
  addpath("TestBlocklib/Logistics/Gate");
  act_out = testGate();
  load("testGate_out.mat");
  verifyEqual(testCase, act_out, testGate_out)
  rmpath("TestBlocklib/Logistics/Gate");
end
function test_blocklib_nserver_case1(testCase)
  addpath("TestBlocklib/Logistics/Nserver");
  act_out = testNserver(1);
  load("testNserver_out1.mat");
  verifyEqual(testCase, act_out, testNserver_out)
  rmpath("TestBlocklib/Logistics/Nserver");
end
function test_blocklib_nserver_case2(testCase)
  addpath("TestBlocklib/Logistics/Nserver");
  act_out = testNserver(2);
  load("testNserver_out2.mat");
  verifyEqual(testCase, act_out, testNserver_out)
  rmpath("TestBlocklib/Logistics/Nserver");
end
function test_blocklib_nserver_case3(testCase)
  addpath("TestBlocklib/Logistics/Nserver");
  act_out = testNserver(3);
  load("testNserver_out3.mat");
  verifyEqual(testCase, act_out, testNserver_out)
  rmpath("TestBlocklib/Logistics/Nserver");
end
function test_blocklib_nserver1(testCase)
  addpath("TestBlocklib/Logistics/Nserver");
  act_out = testNserver1();
  load("testNserver1_out.mat");
  verifyEqual(testCase, act_out, testNserver1_out)
  rmpath("TestBlocklib/Logistics/Nserver");
end
function test_blocklib_queue(testCase)
  addpath("TestBlocklib/Logistics/Queue");
  act_out = testQueue();
  load("testQueue_out.mat");
  verifyEqual(testCase, act_out, testQueue_out)
  rmpath("TestBlocklib/Logistics/Queue");
end
function test_blocklib_queue1(testCase)
  addpath("TestBlocklib/Logistics/Queue");
  act_out = testQueue1();
  load("testQueue1_out.mat");
  verifyEqual(testCase, act_out, testQueue1_out)
  rmpath("TestBlocklib/Logistics/Queue");
end
function test_blocklib_readdata(testCase)
  addpath("TestBlocklib/Logistics/Readdata");
  act_out = testReaddata();
  load("testReaddata_out.mat");
  verifyEqual(testCase, act_out, testReaddata_out)
  rmpath("TestBlocklib/Logistics/Readdata");
end
function test_blocklib_server_case1(testCase)
  addpath("TestBlocklib/Logistics/Server");
  act_out = testServer(1);
  load("testServer_out1.mat");
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestBlocklib/Logistics/Server");
end
function test_blocklib_server_case2(testCase)
  addpath("TestBlocklib/Logistics/Server");
  act_out = testServer(2);
  load("testServer_out2.mat");
  verifyEqual(testCase, act_out, testServer_out)
  rmpath("TestBlocklib/Logistics/Server");
end
function test_blocklib_terminator(testCase)
  addpath("TestBlocklib/Logistics/Terminator");
  act_out = testTerminator();
  load("testTerminator_out.mat");
  verifyEqual(testCase, act_out, testTerminator_out)
  rmpath("TestBlocklib/Logistics/Terminator");
end
function test_blocklib_isentity(testCase)
  addpath("TestBlocklib/Logistics/Isentity");
  act_out = testIsentity();
  load("testIsentity_out.mat");
  verifyEqual(testCase, act_out, testIsentity_out)
  rmpath("TestBlocklib/Logistics/Isentity");
end
function test_blocklib_unbatch(testCase)
  addpath("TestBlocklib/Logistics/Unbatch");
  act_out = testUnbatch();
  load("testUnbatch_out.mat");
  verifyEqual(testCase, act_out, testUnbatch_out)
  rmpath("TestBlocklib/Logistics/Unbatch");
end
function test_blocklib_unbatch1_case1(testCase)
  addpath("TestBlocklib/Logistics/Unbatch");
  act_out = testUnbatch1(1);
  load("testUnbatch1_out1.mat");
  verifyEqual(testCase, act_out, testUnbatch1_out1)
  rmpath("TestBlocklib/Logistics/Unbatch");
end
function test_blocklib_unbatch1_case2(testCase)
  addpath("TestBlocklib/Logistics/Unbatch");
  act_out = testUnbatch1(2);
  load("testUnbatch1_out2.mat");
  verifyEqual(testCase, act_out, testUnbatch1_out2)
  rmpath("TestBlocklib/Logistics/Unbatch");
end
function test_blocklib_unbatch2(testCase)
  addpath("TestBlocklib/Logistics/Unbatch");
  act_out = testUnbatch2();
  load("testUnbatch2_out.mat");
  verifyEqual(testCase, act_out, testUnbatch2_out)
  rmpath("TestBlocklib/Logistics/Unbatch");
end
function test_blocklib_unbatch3(testCase)
  addpath("TestBlocklib/Logistics/Unbatch");
  act_out = testUnbatch3();
  load("testUnbatch3_out.mat");
  verifyEqual(testCase, act_out, testUnbatch3_out)
  rmpath("TestBlocklib/Logistics/Unbatch");
end
function test_blocklib_writedata(testCase)
  addpath("TestBlocklib/Logistics/Writedata");
  act_out = testWritedata();
  load("testWritedata_out.mat");
  verifyEqual(testCase, act_out, testWritedata_out)
  rmpath("TestBlocklib/Logistics/Writedata");
end
function test_blocklib_expnserver(testCase)
  addpath("TestBlocklib/Logistics/Expnserver");
  act_out = testExpnserver();
  load("testExpnserver_out.mat");
  verifyEqual(testCase, act_out, testExpnserver_out)
  rmpath("TestBlocklib/Logistics/Expnserver");
end
function test_blocklib_expnserver1(testCase)
  addpath("TestBlocklib/Logistics/Expnserver");
  act_out = testExpnserver1();
  load("testExpnserver1_out.mat");
  verifyEqual(testCase, act_out, testExpnserver1_out)
  rmpath("TestBlocklib/Logistics/Expnserver");
end
function test_blocklib_expnserver2(testCase)
  addpath("TestBlocklib/Logistics/Expnserver");
  act_out = testExpnserver2();
  load("testExpnserver2_out.mat");
  verifyEqual(testCase, act_out, testExpnserver2_out)
  rmpath("TestBlocklib/Logistics/Expnserver");
end
function test_blocklib_queue_en(testCase)
  addpath("TestBlocklib/Logistics/Queue_en");
  act_out = testQueue_en();
  load("testQueue_en_out.mat");
  verifyEqual(testCase, act_out, testQueue_en_out)
  rmpath("TestBlocklib/Logistics/Queue_en");
end
function test_blocklib_queue_server(testCase)
  addpath("TestBlocklib/Logistics/Queue_server");
  act_out = test_cm_queue_server();
  load("test_cm_queue_server_out.mat");
  verifyEqual(testCase, act_out, test_cm_queue_server_out)
  rmpath("TestBlocklib/Logistics/Queue_server");
end
%%%%%%%%%%%%%%%%%%%%Math operations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_add2(testCase)
  addpath("TestBlocklib/MathOperations/Add2");
  act_out = testAdd2();
  load("testAdd2_out.mat");
  verifyEqual(testCase, act_out, testAdd2_out)
  rmpath("TestBlocklib/MathOperations/Add2");
end
function test_blocklib_add3(testCase)
  addpath("TestBlocklib/MathOperations/Add3");
  act_out = testAdd3();
  load("testAdd3_out.mat");
  verifyEqual(testCase, act_out, testAdd3_out)
  rmpath("TestBlocklib/MathOperations/Add3");
end
function test_blocklib_add4(testCase)
  addpath("TestBlocklib/MathOperations/Add4");
  act_out = testAdd4();
  load("testAdd4_out.mat");
  verifyEqual(testCase, act_out, testAdd4_out)
  rmpath("TestBlocklib/MathOperations/Add4");
end
function test_blocklib_add6(testCase)
  addpath("TestBlocklib/MathOperations/Add6");
  act_out = testAdd6();
  load("testAdd6_out.mat");
  verifyEqual(testCase, act_out, testAdd6_out)
  rmpath("TestBlocklib/MathOperations/Add6");
end
function test_blocklib_addN4(testCase)
  addpath("TestBlocklib/MathOperations/AddN");
  act_out = testAddN4();
  load("testAddN4_out.mat");
  verifyEqual(testCase, act_out, testAddN4_out)
  rmpath("TestBlocklib/MathOperations/AddN");
end
function test_blocklib_addN4a(testCase)
  addpath("TestBlocklib/MathOperations/AddN");
  act_out = testAddN4a();
  load("testAddN4a_out.mat");
  verifyEqual(testCase, act_out, testAddN4a_out)
  rmpath("TestBlocklib/MathOperations/AddN");
end
function test_blocklib_addN(testCase)
  addpath("TestBlocklib/MathOperations/AddN");
  act_out = testAddN();
  load("testAddN_out.mat");
  verifyEqual(testCase, act_out, testAddN_out)
  rmpath("TestBlocklib/MathOperations/AddN");
end
function test_blocklib_comparator(testCase)
  addpath("TestBlocklib/MathOperations/Comparator");
  act_out = testComparator();
  load("testComparator_out.mat");
  verifyEqual(testCase, act_out, testComparator_out)
  rmpath("TestBlocklib/MathOperations/Comparator");
end
function test_blocklib_Gain(testCase)
  addpath("TestBlocklib/MathOperations/Gain");
  act_out = testGain();
  load("testGain_out.mat");
  verifyEqual(testCase, act_out, testGain_out)
  rmpath("TestBlocklib/MathOperations/Gain");
end
function test_blocklib_mult2(testCase)
  addpath("TestBlocklib/MathOperations/Mult2");
  act_out = testMult2();
  load("testMult2_out.mat");
  verifyEqual(testCase, act_out, testMult2_out)
  rmpath("TestBlocklib/MathOperations/Mult2");
end
function test_blocklib_mult3(testCase)
  addpath("TestBlocklib/MathOperations/Mult3");
  act_out = testMult3();
  load("testMult3_out.mat");
  verifyEqual(testCase, act_out, testMult3_out)
  rmpath("TestBlocklib/MathOperations/Mult3");
end
function test_blocklib_saturation(testCase)
  addpath("TestBlocklib/MathOperations/Saturation");
  act_out = testSaturation();
  load("testSaturation_out.mat");
  verifyEqual(testCase, act_out, testSaturation_out)
  rmpath("TestBlocklib/MathOperations/Saturation");
end

%%%%%%%%%%%%%%%%%%%%QSS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_hIntegrator(testCase)
  addpath("TestBlocklib/Qss/Hintegrator");
  act_out = testhIntegrator();
  load("testhIntegrator_out.mat");
  verifyEqual(testCase, act_out, testhIntegrator_out)
  rmpath("TestBlocklib/Qss/Hintegrator");
end

%%%%%%%%%%%%%%%%%%%%Routing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_collect2(testCase)
  addpath("TestBlocklib/Routing/Collect2");
  act_out = testCollect2();
  load("testCollect2_out.mat");
  verifyEqual(testCase, act_out, testCollect2_out)
  rmpath("TestBlocklib/Routing/Collect2");
end
function test_blocklib_collect2a(testCase)
  addpath("TestBlocklib/Routing/Collect2");
  act_out = testCollect2a();
  load("testCollect2a_out.mat");
  verifyEqual(testCase, act_out, testCollect2a_out)
  rmpath("TestBlocklib/Routing/Collect2");
end
function test_blocklib_collect3(testCase)
  addpath("TestBlocklib/Routing/Collect3");
  act_out = testCollect3();
  load("testCollect3_out.mat");
  verifyEqual(testCase, act_out, testCollect3_out)
  rmpath("TestBlocklib/Routing/Collect3");
end
function test_blocklib_collect4(testCase)
  addpath("TestBlocklib/Routing/Collect4");
  act_out = testCollect4();
  load("testCollect4_out.mat");
  verifyEqual(testCase, act_out, testCollect4_out)
  rmpath("TestBlocklib/Routing/Collect4");
end
function test_blocklib_collectN4(testCase)
  addpath("TestBlocklib/Routing/CollectN");
  act_out = testCollectN4();
  load("testCollectN4_out.mat");
  verifyEqual(testCase, act_out, testCollectN4_out)
  rmpath("TestBlocklib/Routing/CollectN");
end
function test_blocklib_collectN(testCase)
  addpath("TestBlocklib/Routing/CollectN");
  act_out = testCollectN();
  load("testCollectN_out.mat");
  verifyEqual(testCase, act_out, testCollectN_out)
  rmpath("TestBlocklib/Routing/CollectN");
end
function test_blocklib_distribute2(testCase)
  addpath("TestBlocklib/Routing/Distribute2");
  act_out = testDistribute2();
  load("testDistribute2_out.mat");
  verifyEqual(testCase, act_out, testDistribute2_out)
  rmpath("TestBlocklib/Routing/Distribute2");
end
function test_blocklib_distribute2a(testCase)
  addpath("TestBlocklib/Routing/Distribute2");
  act_out = testDistribute2a();
  load("testDistribute2a_out.mat");
  verifyEqual(testCase, act_out, testDistribute2a_out)
  rmpath("TestBlocklib/Routing/Distribute2");
end
function test_blocklib_distribute3(testCase)
  addpath("TestBlocklib/Routing/Distribute3");
  act_out = testDistribute3();
  load("testDistribute3_out.mat");
  verifyEqual(testCase, act_out, testDistribute3_out)
  rmpath("TestBlocklib/Routing/Distribute3");
end
function test_blocklib_distribute4(testCase)
  addpath("TestBlocklib/Routing/Distribute4");
  act_out = testDistribute4();
  load("testDistribute4_out.mat");
  verifyEqual(testCase, act_out, testDistribute4_out)
  rmpath("TestBlocklib/Routing/Distribute4");
end
function test_blocklib_distributeN4(testCase)
  addpath("TestBlocklib/Routing/DistributeN");
  act_out = testDistributeN4();
  load("testDistributeN4_out.mat");
  verifyEqual(testCase, act_out, testDistributeN4_out)
  rmpath("TestBlocklib/Routing/DistributeN");
end
function test_blocklib_outputswitch(testCase)
  addpath("TestBlocklib/Routing/Outputswitch");
  act_out = testOutputswitch();
  load("testOutputswitch_out.mat");
  verifyEqual(testCase, act_out, testOutputswitch_out)
  rmpath("TestBlocklib/Routing/Outputswitch");
end
function test_blocklib_inputswitch(testCase)
  addpath("TestBlocklib/Routing/Inputswitch");
  act_out = testInputswitch();
  load("testInputswitch_out.mat");
  verifyEqual(testCase, act_out, testInputswitch_out)
  rmpath("TestBlocklib/Routing/Inputswitch");
end
function test_blocklib_smallestin3(testCase)
  addpath("TestBlocklib/Routing/Smallestin3");
  act_out = testSmallestin3();
  load("testSmallestin3_out.mat");
  verifyEqual(testCase, act_out, testSmallestin3_out)
  rmpath("TestBlocklib/Routing/Smallestin3");
end
function test_blocklib_smallestin4(testCase)
  addpath("TestBlocklib/Routing/Smallestin4");
  act_out = testSmallestin4();
  load("testSmallestin4_out.mat");
  verifyEqual(testCase, act_out, testSmallestin4_out)
  rmpath("TestBlocklib/Routing/Smallestin4");
end
function test_blocklib_smallestinN4(testCase)
  addpath("TestBlocklib/Routing/SmallestinN");
  act_out = testSmallestinN4();
  load("testSmallestinN4_out.mat");
  verifyEqual(testCase, act_out, testSmallestinN4_out)
  rmpath("TestBlocklib/Routing/SmallestinN");
end

%%%%%%%%%%%%%%%%%%%%Sinks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_stop(testCase)
  addpath("TestBlocklib/Sinks/Stop");
  act_out = testStop();
  load("testStop_out.mat");
  verifyEqual(testCase, act_out, testStop_out)
  rmpath("TestBlocklib/Sinks/Stop");
end
function test_blocklib_toworkspace(testCase)
  addpath("TestBlocklib/Sinks/Toworkspace");
  act_out = testToworkspace();
  load("testToworkspace_out.mat");
  verifyEqual(testCase, act_out, testToworkspace_out)
  rmpath("TestBlocklib/Sinks/Toworkspace");
end

%%%%%%%%%%%%%%%%%%%%Sources%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_fromworkspace(testCase)
  addpath("TestBlocklib/Sources/Fromworkspace");
  act_out = testFromworkspace();
  load("testFromworkspace_out.mat");
  verifyEqual(testCase, act_out, testFromworkspace_out)
  rmpath("TestBlocklib/Sources/Fromworkspace");
end
function test_blocklib_Generator(testCase)
  addpath("TestBlocklib/Sources/Generator");
  act_out = testGenerator();
  load("testGenerator_out.mat");
  verifyEqual(testCase, act_out, testGenerator_out)
  rmpath("TestBlocklib/Sources/Generator");
end
function test_blocklib_vectorgen(testCase)
  addpath("TestBlocklib/Sources/Vectorgen");
  act_out = testVectorgen();
  load("testVectorgen_out.mat");
  verifyEqual(testCase, act_out, testVectorgen_out)
  rmpath("TestBlocklib/Sources/Vectorgen");
end
function test_blocklib_bingenerator(testCase)
  addpath("TestBlocklib/Sources/Bingenerator");
  act_out = testBingenerator();
  load("testBingenerator_out.mat");
  verifyEqual(testCase, act_out, testBingenerator_out)
  rmpath("TestBlocklib/Sources/Bingenerator");
end
function test_blocklib_Const(testCase)
  addpath("TestBlocklib/Sources/Const");
  act_out = testConst();
  load("testConst_out.mat");
  verifyEqual(testCase, act_out, testConst_out)
  rmpath("TestBlocklib/Sources/Const");
end
function test_blocklib_enabledgenerator(testCase)
  addpath("TestBlocklib/Sources/EnabledGenerator");
  act_out = testEnabledGenerator();
  load("testEnabledGenerator_out.mat");
  verifyEqual(testCase, act_out, testEnabledGenerator_out)
  rmpath("TestBlocklib/Sources/EnabledGenerator");
end

%%%%%%%%%%%%%%%%%%%%Statistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_blocklib_utilization(testCase)
  addpath("TestBlocklib/Statistics/Utilization");
  act_out = testUtilization();
  load("testUtilization_out.mat");
  verifyEqual(testCase, act_out, testUtilization_out)
  rmpath("TestBlocklib/Statistics/Utilization");
end
function test_blocklib_getmax(testCase)
  addpath("TestBlocklib/Statistics/Getmax");
  act_out = testGetmax();
  load("testGetmax_out.mat");
  verifyEqual(testCase, act_out, testGetmax_out)
  rmpath("TestBlocklib/Statistics/Getmax");
end

%%%%%%%%%%%%%%%%%%%%Digital%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Converter
function am_bin8_to_decblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Converter/Bin8_to_dec");
  act_out = test_am_bin8_to_dec();
  load("test_am_bin8_to_dec_out.mat");
  verifyEqual(testCase, act_out, test_am_bin8_to_dec_out)
  rmpath("TestBlocklib/Digital/Converter/Bin8_to_dec");
end
function am_dec_to_bin8blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Converter/Dec_to_bin8");
  act_out = test_am_dec_to_bin8();
  load("test_am_dec_to_bin8_out.mat");
  verifyEqual(testCase, act_out, test_am_dec_to_bin8_out)
  rmpath("TestBlocklib/Digital/Converter/Dec_to_bin8");
end
function am_bin_to_doubleblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Converter/Bin_to_double");
  act_out = test_am_bin_to_double();
  load("test_am_bin_to_double_out.mat");
  verifyEqual(testCase, act_out, test_am_bin_to_double_out)
  rmpath("TestBlocklib/Digital/Converter/Bin_to_double");
end

%%Logic
function am_nand2blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Nand2");
  act_out = test_am_nand2();
  load("test_am_nand2_out.mat");
  verifyEqual(testCase, act_out, test_am_nand2_out)
  rmpath("TestBlocklib/Digital/Logic/Nand2");
end
function am_nand3blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Nand3");
  act_out = test_am_nand3();
  load("test_am_nand3_out.mat");
  verifyEqual(testCase, act_out, test_am_nand3_out)
  rmpath("TestBlocklib/Digital/Logic/Nand3");
end
function am_nand4blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Nand4");
  act_out = test_am_nand4();
  load("test_am_nand4_out.mat");
  verifyEqual(testCase, act_out, test_am_nand4_out)
  rmpath("TestBlocklib/Digital/Logic/Nand4");
end
function am_notgateblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Not");
  act_out = test_am_not();
  load("test_am_not_out.mat");
  verifyEqual(testCase, act_out, test_am_not_out)
  rmpath("TestBlocklib/Digital/Logic/Not");
end
function am_or2blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Or2");
  act_out = test_am_or2();
  load("test_am_or2_out.mat");
  verifyEqual(testCase, act_out, test_am_or2_out)
  rmpath("TestBlocklib/Digital/Logic/Or2");
end
function cm_and2blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/And2");
  act_out = test_cm_and2();
  load("test_cm_and2_out.mat");
  verifyEqual(testCase, act_out, test_cm_and2_out)
  rmpath("TestBlocklib/Digital/Logic/And2");
end
function cm_notblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/NotC");
  act_out = test_cm_not();
  load("test_cm_not_out.mat");
  verifyEqual(testCase, act_out, test_cm_not_out)
  rmpath("TestBlocklib/Digital/Logic/NotC");
end
function cm_or2blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Or2C");
  act_out = test_cm_or2();
  load("test_cm_or2_out.mat");
  verifyEqual(testCase, act_out, test_cm_or2_out)
  rmpath("TestBlocklib/Digital/Logic/Or2C");
end
function cm_xor2blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Xor2");
  act_out = test_cm_xor2();
  load("test_cm_xor2_out.mat");
  verifyEqual(testCase, act_out, test_cm_xor2_out)
  rmpath("TestBlocklib/Digital/Logic/Xor2");
end
function cm_Mux2to1blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Mux2to1");
  act_out = test_cm_Mux2to1();
  load("test_cm_Mux2to1_out.mat");
  verifyEqual(testCase, act_out, test_cm_Mux2to1_out)
  rmpath("TestBlocklib/Digital/Logic/Mux2to1");
end
function cm_Mux4to1blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Mux4to1");
  act_out = test_cm_Mux4to1();
  load("test_cm_Mux4to1_out.mat");
  verifyEqual(testCase, act_out, test_cm_Mux4to1_out)
  rmpath("TestBlocklib/Digital/Logic/Mux4to1");
end
function cm_halfadderblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Halfadder");
  act_out = test_cm_halfadder();
  load("test_cm_halfadder_out.mat");
  verifyEqual(testCase, act_out, test_cm_halfadder_out)
  rmpath("TestBlocklib/Digital/Logic/Halfadder");
end
function cm_fulladderblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Fulladder");
  act_out = test_cm_fulladder();
  load("test_cm_fulladder_out.mat");
  verifyEqual(testCase, act_out, test_cm_fulladder_out)
  rmpath("TestBlocklib/Digital/Logic/Fulladder");
end
function cm_nand4blocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Nand4C");
  act_out = test_cm_nand4();
  load("test_cm_nand4_out.mat");
  verifyEqual(testCase, act_out, test_cm_nand4_out)
  rmpath("TestBlocklib/Digital/Logic/Nand4C");
end
function cm_rising_edgeblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Rising_edge");
  act_out = test_cm_rising_edge();
  load("test_cm_rising_edge_out.mat");
  verifyEqual(testCase, act_out, test_cm_rising_edge_out)
  rmpath("TestBlocklib/Digital/Logic/Rising_edge");
end
function cm_falling_edgeblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Falling_edge");
  act_out = test_cm_falling_edge();
  load("test_cm_falling_edge_out.mat");
  verifyEqual(testCase, act_out, test_cm_falling_edge_out)
  rmpath("TestBlocklib/Digital/Logic/Falling_edge");
end
function cm_carry_ripple_adder_8bitblocklib_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Carry_ripple_adder_8bit");
  act_out = test_cm_carry_ripple_adder_8bit();
  load("test_cm_carry_ripple_adder_8bit_out.mat");
  verifyEqual(testCase, act_out, test_cm_carry_ripple_adder_8bit_out)
  rmpath("TestBlocklib/Digital/Logic/Carry_ripple_adder_8bit");
end
%Model by Model verification
function MMVblocklib_not_test(testCase)
  addpath("TestBlocklib/Digital/Logic/NotC");
  addpath("TestBlocklib/Digital/Logic/Not");
  out_cm = test_cm_not();
  out_am = test_am_not();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestBlocklib/Digital/Logic/NotC");
  rmpath("TestBlocklib/Digital/Logic/Not");
end
function MMVblocklib_or2_test(testCase)
  addpath("TestBlocklib/Digital/Logic/Or2C");
  addpath("TestBlocklib/Digital/Logic/Or2");
  out_cm = test_cm_or2();
  out_am = test_am_or2();
  verifyEqual(testCase, out_cm, out_am)
  rmpath("TestBlocklib/Digital/Logic/Or2C");
  rmpath("TestBlocklib/Digital/Logic/Or2");
end

%%Flip Flops
function am_jk_flip_flopblocklib_test(testCase)
  addpath("TestBlocklib/Digital/FlipFlops/JKFF");
  act_out = test_am_jk_flip_flop();
  load("test_am_jk_flip_flop_out.mat");
  verifyEqual(testCase, act_out, test_am_jk_flip_flop_out)
  rmpath("TestBlocklib/Digital/FlipFlops/JKFF");
end
