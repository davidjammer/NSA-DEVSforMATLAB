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
%%atomic
function test_add2(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Add2");
	act_out = testAdd2();
	load('testAdd2_out.mat');
	verifyEqual(testCase, act_out, testAdd2_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Add2");
end
function test_add3(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Add3");
	act_out = testAdd3();
	load('testAdd3_out.mat');
	verifyEqual(testCase, act_out, testAdd3_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Add3");
end
function test_add4(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Add4");
	act_out = testAdd4();
	load('testAdd4_out.mat');
	verifyEqual(testCase, act_out, testAdd4_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Add4");
end
function test_add6(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Add6");
	act_out = testAdd6();
	load('testAdd6_out.mat');
	verifyEqual(testCase, act_out, testAdd6_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Add6");
end
function test_comparator(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Comparator");
	act_out = testComparator();
	load('testComparator_out.mat');
	verifyEqual(testCase, act_out, testComparator_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Comparator");
end
function test_Gain(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Gain");
	act_out = testGain();
	load('testGain_out.mat');
	verifyEqual(testCase, act_out, testGain_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Gain");
end
function test_Div(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Div");
	act_out = testDiv();
	load('testDiv_out.mat');
	verifyEqual(testCase, act_out, testDiv_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Div");
end
function test_multi2(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Multi2");
	act_out = testMulti2();
	load('testMulti2_out.mat');
	verifyEqual(testCase, act_out, testMulti2_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Multi2");
end
function test_multi3(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Multi3");
	act_out = testMulti3();
	load('testMulti3_out.mat');
	verifyEqual(testCase, act_out, testMulti3_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Multi3");
end
function test_saturation(testCase)
    addpath("TestCases/Modelbase/MathOperations/atomic/Saturation");
	act_out = testSaturation();
	load('testSaturation_out.mat');
	verifyEqual(testCase, act_out, testSaturation_out)
	rmpath("TestCases/Modelbase/MathOperations/atomic/Saturation");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Logistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_batch(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Batch");
	act_out = testBatch();
	load('testBatch_out.mat');
	verifyEqual(testCase, act_out, testBatch_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Batch");
end
function test_delay(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Delay");
	act_out = testDelay();
	load('testDelay_out.mat');
	verifyEqual(testCase, act_out, testDelay_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Delay");
end
function test_queue(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Queue");
	act_out = testQueue();
	load('testQueue_out.mat');
	verifyEqual(testCase, act_out, testQueue_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Queue");
end
function test_server_case1(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Server");
	act_out = testServer(1);
	load('testServer_out1.mat');
	verifyEqual(testCase, act_out, testServer_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Server");
end
function test_server_case2(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Server");
	act_out = testServer(2);
	load('testServer_out2.mat');
	verifyEqual(testCase, act_out, testServer_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Server");
end
function test_unbatch(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Unbatch");
	act_out = testUnbatch();
	load('testUnbatch_out.mat');
	verifyEqual(testCase, act_out, testUnbatch_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Unbatch");
end

function test_terminator(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Terminator");
	act_out = testTerminator();
	load('testTerminator_out.mat');
	verifyEqual(testCase, act_out, testTerminator_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Terminator");
end
function test_gate(testCase)
    addpath("TestCases/Modelbase/Logistics/atomic/Gate");
	act_out = testGate();
	load('testGate_out.mat');
	verifyEqual(testCase, act_out, testGate_out)
	rmpath("TestCases/Modelbase/Logistics/atomic/Gate");
end
%%coupled
function test_queue_en(testCase)
    addpath("TestCases/Modelbase/Logistics/coupled/Queue_en");
	act_out = testQueue_en();
	load('testQueue_en_out.mat');
	verifyEqual(testCase, act_out, testQueue_en_out)
	rmpath("TestCases/Modelbase/Logistics/coupled/Queue_en");
end
function test_queue_server(testCase)
    addpath("TestCases/Modelbase/Logistics/coupled/Queue_server");
	act_out = test_cm_queue_server();
	load('test_cm_queue_server_out.mat');
	verifyEqual(testCase, act_out, test_cm_queue_server_out)
	rmpath("TestCases/Modelbase/Logistics/coupled/Queue_server");
end
%%%%%%%%%%%%%%%%%%%%Routing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_combine3(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Combine3");
	act_out = testCombine3();
	load('testCombine3_out.mat');
	verifyEqual(testCase, act_out, testCombine3_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Combine3");
end
function test_combine4(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Combine4");
	act_out = testCombine4();
	load('testCombine4_out.mat');
	verifyEqual(testCase, act_out, testCombine4_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Combine4");
end
function test_distribute2(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Distribute2");
	act_out = testDistribute2();
	load('testDistribute2_out.mat');
	verifyEqual(testCase, act_out, testDistribute2_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Distribute2");
end
function test_distribute3(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Distribute3");
	act_out = testDistribute3();
	load('testDistribute3_out.mat');
	verifyEqual(testCase, act_out, testDistribute3_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Distribute3");
end
function test_distribute4(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Distribute4");
	act_out = testDistribute4();
	load('testDistribute4_out.mat');
	verifyEqual(testCase, act_out, testDistribute4_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Distribute4");
end
function test_outputswitch(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Outputswitch");
	act_out = testOutputswitch();
	load('testOutputswitch_out.mat');
	verifyEqual(testCase, act_out, testOutputswitch_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Outputswitch");
end
function test_smallestin3(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Smallestin3");
	act_out = testSmallestin3();
	load('testSmallestin3_out.mat');
	verifyEqual(testCase, act_out, testSmallestin3_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Smallestin3");
end
function test_smallestin4(testCase)
    addpath("TestCases/Modelbase/Routing/atomic/Smallestin4");
	act_out = testSmallestin4();
	load('testSmallestin4_out.mat');
	verifyEqual(testCase, act_out, testSmallestin4_out)
	rmpath("TestCases/Modelbase/Routing/atomic/Smallestin4");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Sinks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_toworkspace(testCase)
    addpath("TestCases/Modelbase/Sinks/atomic/Toworkspace");
	act_out = testToworkspace();
	load('testToworkspace_out.mat');
	verifyEqual(testCase, act_out, testToworkspace_out)
	rmpath("TestCases/Modelbase/Sinks/atomic/Toworkspace");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Sources%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_fromworkspace(testCase)
    addpath("TestCases/Modelbase/Sources/atomic/Fromworkspace");
	act_out = testFromworkspace();
	load('testFromworkspace_out.mat');
	verifyEqual(testCase, act_out, testFromworkspace_out)
	rmpath("TestCases/Modelbase/Sources/atomic/Fromworkspace");
end
function test_Generator(testCase)
    addpath("TestCases/Modelbase/Sources/atomic/Generator");
	act_out = testGenerator();
	load('testGenerator_out.mat');
	verifyEqual(testCase, act_out, testGenerator_out)
	rmpath("TestCases/Modelbase/Sources/atomic/Generator");
end
function test_vectorgen(testCase)
    addpath("TestCases/Modelbase/Sources/atomic/Vectorgen");
	act_out = testVectorgen();
	load('testVectorgen_out.mat');
	verifyEqual(testCase, act_out, testVectorgen_out)
	rmpath("TestCases/Modelbase/Sources/atomic/Vectorgen");
end
function test_bingenerator(testCase)
    addpath("TestCases/Modelbase/Sources/atomic/Bingenerator");
	act_out = testBingenerator();
	load('testBingenerator_out.mat');
	verifyEqual(testCase, act_out, testBingenerator_out)
	rmpath("TestCases/Modelbase/Sources/atomic/Bingenerator");
end
function test_Const(testCase)
    addpath("TestCases/Modelbase/Sources/atomic/Const");
	act_out = testConst();
	load('testConst_out.mat');
	verifyEqual(testCase, act_out, testConst_out)
	rmpath("TestCases/Modelbase/Sources/atomic/Const");
end
function test_enabledgenerator(testCase)
    addpath("TestCases/Modelbase/Sources/atomic/EnabledGenerator");
	act_out = testEnabledGenerator();
	load('testEnabledGenerator_out.mat');
	verifyEqual(testCase, act_out, testEnabledGenerator_out)
	rmpath("TestCases/Modelbase/Sources/atomic/EnabledGenerator");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%QSS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_hIntegrator(testCase)
    addpath("TestCases/Modelbase/Qss/atomic/Hintegrator");
	act_out = testhIntegrator();
	load('testhIntegrator_out.mat');
	verifyEqual(testCase, act_out, testhIntegrator_out)
	rmpath("TestCases/Modelbase/Qss/atomic/Hintegrator");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Digital%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Converter
%atomic
function am_bin8_to_dec_test(testCase)
    addpath("TestCases/Modelbase/Digital/Converter/atomic/Bin8_to_dec");
	act_out = test_am_bin8_to_dec();
	load('test_am_bin8_to_dec_out.mat');
	verifyEqual(testCase, act_out, test_am_bin8_to_dec_out)
	rmpath("TestCases/Modelbase/Digital/Converter/atomic/Bin8_to_dec");
end
function am_dec_to_bin8_test(testCase)
    addpath("TestCases/Modelbase/Digital/Converter/atomic/Dec_to_bin8");
	act_out = test_am_dec_to_bin8();
	load('test_am_dec_to_bin8_out.mat');
	verifyEqual(testCase, act_out, test_am_dec_to_bin8_out)
	rmpath("TestCases/Modelbase/Digital/Converter/atomic/Dec_to_bin8");
end
function am_bin_to_double_test(testCase)
    addpath("TestCases/Modelbase/Digital/Converter/atomic/Bin_to_double");
	act_out = test_am_bin_to_double();
	load('test_am_bin_to_double_out.mat');
	verifyEqual(testCase, act_out, test_am_bin_to_double_out)
	rmpath("TestCases/Modelbase/Digital/Converter/atomic/Bin_to_double");
end
%coupled

%%Logic
%atomic
function am_nand2_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/atomic/Nand2");
	act_out = test_am_nand2();
	load('test_am_nand2_out.mat');
	verifyEqual(testCase, act_out, test_am_nand2_out)
	rmpath("TestCases/Modelbase/Digital/Logic/atomic/Nand2");
end
function am_nand3_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/atomic/Nand3");
	act_out = test_am_nand3();
	load('test_am_nand3_out.mat');
	verifyEqual(testCase, act_out, test_am_nand3_out)
	rmpath("TestCases/Modelbase/Digital/Logic/atomic/Nand3");
end
function am_nand4_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/atomic/Nand4");
	act_out = test_am_nand4();
	load('test_am_nand4_out.mat');
	verifyEqual(testCase, act_out, test_am_nand4_out)
	rmpath("TestCases/Modelbase/Digital/Logic/atomic/Nand4");
end
function am_notgate_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/atomic/Not");
	act_out = test_am_not();
	load('test_am_not_out.mat');
	verifyEqual(testCase, act_out, test_am_not_out)
	rmpath("TestCases/Modelbase/Digital/Logic/atomic/Not");
end
function am_or2_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/atomic/Or2");
	act_out = test_am_or2();
	load('test_am_or2_out.mat');
	verifyEqual(testCase, act_out, test_am_or2_out)
	rmpath("TestCases/Modelbase/Digital/Logic/atomic/Or2");
end
%coupled
function cm_and2_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/And2");
	act_out = test_cm_and2();
	load('test_cm_and2_out.mat');
	verifyEqual(testCase, act_out, test_cm_and2_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/And2");
end
function cm_not_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Not");
	act_out = test_cm_not();
	load('test_cm_not_out.mat');
	verifyEqual(testCase, act_out, test_cm_not_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Not");
end
function cm_or2_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Or2");
	act_out = test_cm_or2();
	load('test_cm_or2_out.mat');
	verifyEqual(testCase, act_out, test_cm_or2_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Or2");
end
function cm_xor2_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Xor2");
	act_out = test_cm_xor2();
	load('test_cm_xor2_out.mat');
	verifyEqual(testCase, act_out, test_cm_xor2_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Xor2");
end
function cm_Mux2to1_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Mux2to1");
	act_out = test_cm_Mux2to1();
	load('test_cm_Mux2to1_out.mat');
	verifyEqual(testCase, act_out, test_cm_Mux2to1_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Mux2to1");
end
function cm_Mux4to1_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Mux4to1");
	act_out = test_cm_Mux4to1();
	load('test_cm_Mux4to1_out.mat');
	verifyEqual(testCase, act_out, test_cm_Mux4to1_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Mux4to1");
end
function cm_halfadder_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Halfadder");
	act_out = test_cm_halfadder();
	load('test_cm_halfadder_out.mat');
	verifyEqual(testCase, act_out, test_cm_halfadder_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Halfadder");
end
function cm_fulladder_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Fulladder");
	act_out = test_cm_fulladder();
	load('test_cm_fulladder_out.mat');
	verifyEqual(testCase, act_out, test_cm_fulladder_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Fulladder");
end
function cm_nand4_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Nand4");
	act_out = test_cm_nand4();
	load('test_cm_nand4_out.mat');
	verifyEqual(testCase, act_out, test_cm_nand4_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Nand4");
end
function cm_rising_edge_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Rising_edge");
	act_out = test_cm_rising_edge();
	load('test_cm_rising_edge_out.mat');
	verifyEqual(testCase, act_out, test_cm_rising_edge_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Rising_edge");
end
function cm_falling_edge_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Falling_edge");
	act_out = test_cm_falling_edge();
	load('test_cm_falling_edge_out.mat');
	verifyEqual(testCase, act_out, test_cm_falling_edge_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Falling_edge");
end
function cm_carry_ripple_adder_8bit_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Carry_ripple_adder_8bit");
	act_out = test_cm_carry_ripple_adder_8bit();
	load('test_cm_carry_ripple_adder_8bit_out.mat');
	verifyEqual(testCase, act_out, test_cm_carry_ripple_adder_8bit_out)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Carry_ripple_adder_8bit");
end
%Model by Model verification
function MMV_not_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Not");
    addpath("TestCases/Modelbase/Digital/Logic/atomic/Not");
	out_cm = test_cm_not();
	out_am = test_am_not();
	verifyEqual(testCase, out_cm, out_am)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Not");
    rmpath("TestCases/Modelbase/Digital/Logic/atomic/Not");
end
function MMV_or2_test(testCase)
    addpath("TestCases/Modelbase/Digital/Logic/coupled/Or2");
    addpath("TestCases/Modelbase/Digital/Logic/atomic/Or2");
	out_cm = test_cm_or2();
	out_am = test_am_or2();
	verifyEqual(testCase, out_cm, out_am)
	rmpath("TestCases/Modelbase/Digital/Logic/coupled/Or2");
    rmpath("TestCases/Modelbase/Digital/Logic/atomic/Or2");
end

%%Flip Flops
%atomic
function am_jk_flip_flop_test(testCase)
    addpath("TestCases/Modelbase/Digital/FlipFlops/JK/atomic/JKFF");
	act_out = test_am_jk_flip_flop();
	load('test_am_jk_flip_flop_out.mat');
	verifyEqual(testCase, act_out, test_am_jk_flip_flop_out)
	rmpath("TestCases/Modelbase/Digital/FlipFlops/JK/atomic/JKFF");
end
%coupled

%Model by Model verification

%%%%%%%%%%%%%%%%%%%%Statistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_utilization(testCase)
    addpath("TestCases/Modelbase/Statistics/atomic/Utilization");
	act_out = testUtilization();
	load('testUtilization_out.mat');
	verifyEqual(testCase, act_out, testUtilization_out)
	rmpath("TestCases/Modelbase/Statistics/atomic/Utilization");
end
function test_getmax(testCase)
    addpath("TestCases/Modelbase/Statistics/atomic/Getmax");
	act_out = testGetmax();
	load('testGetmax_out.mat');
	verifyEqual(testCase, act_out, testGetmax_out)
	rmpath("TestCases/Modelbase/Statistics/atomic/Getmax");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Blocklib%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%Logistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_blocklib_batch(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Batch");
	act_out = testBatch();
	load('testBatch_out.mat');
	verifyEqual(testCase, act_out, testBatch_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Batch");
end
function test_blocklib_delay(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Delay");
	act_out = testDelay();
	load('testDelay_out.mat');
	verifyEqual(testCase, act_out, testDelay_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Delay");
end
function test_blocklibgate(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Gate");
	act_out = testGate();
	load('testGate_out.mat');
	verifyEqual(testCase, act_out, testGate_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Gate");
end
function test_blocklibqueue(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Queue");
	act_out = testQueue();
	load('testQueue_out.mat');
	verifyEqual(testCase, act_out, testQueue_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Queue");
end
function test_blocklibserver_case1(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Server");
	act_out = testServer(1);
	load('testServer_out1.mat');
	verifyEqual(testCase, act_out, testServer_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Server");
end
function test_blocklibserver_case2(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Server");
	act_out = testServer(2);
	load('testServer_out2.mat');
	verifyEqual(testCase, act_out, testServer_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Server");
end
function test_blocklibterminator(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Terminator");
	act_out = testTerminator();
	load('testTerminator_out.mat');
	verifyEqual(testCase, act_out, testTerminator_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Terminator");
end
function test_blocklibunbatch(testCase)
    addpath("TestCases/Blocklib/Logistics/atomic/Unbatch");
	act_out = testUnbatch();
	load('testUnbatch_out.mat');
	verifyEqual(testCase, act_out, testUnbatch_out)
	rmpath("TestCases/Blocklib/Logistics/atomic/Unbatch");
end
%%coupled
function test_blocklibqueue_en(testCase)
    addpath("TestCases/Blocklib/Logistics/coupled/Queue_en");
	act_out = testQueue_en();
	load('testQueue_en_out.mat');
	verifyEqual(testCase, act_out, testQueue_en_out)
	rmpath("TestCases/Blocklib/Logistics/coupled/Queue_en");
end
function test_blocklibqueue_server(testCase)
    addpath("TestCases/Blocklib/Logistics/coupled/Queue_server");
	act_out = test_cm_queue_server();
	load('test_cm_queue_server_out.mat');
	verifyEqual(testCase, act_out, test_cm_queue_server_out)
	rmpath("TestCases/Blocklib/Logistics/coupled/Queue_server");
end
%%%%%%%%%%%%%%%%%%%%Math operations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_blocklibadd2(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Add2");
	act_out = testAdd2();
	load('testAdd2_out.mat');
	verifyEqual(testCase, act_out, testAdd2_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Add2");
end
function test_blocklibadd3(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Add3");
	act_out = testAdd3();
	load('testAdd3_out.mat');
	verifyEqual(testCase, act_out, testAdd3_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Add3");
end
function test_blocklibadd4(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Add4");
	act_out = testAdd4();
	load('testAdd4_out.mat');
	verifyEqual(testCase, act_out, testAdd4_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Add4");
end
function test_blocklibadd6(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Add6");
	act_out = testAdd6();
	load('testAdd6_out.mat');
	verifyEqual(testCase, act_out, testAdd6_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Add6");
end
function test_blocklibcomparator(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Comparator");
	act_out = testComparator();
	load('testComparator_out.mat');
	verifyEqual(testCase, act_out, testComparator_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Comparator");
end
function test_blocklibGain(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Gain");
	act_out = testGain();
	load('testGain_out.mat');
	verifyEqual(testCase, act_out, testGain_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Gain");
end
function test_blocklibmulti2(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Multi2");
	act_out = testMulti2();
	load('testMulti2_out.mat');
	verifyEqual(testCase, act_out, testMulti2_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Multi2");
end
function test_blocklibmulti3(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Multi3");
	act_out = testMulti3();
	load('testMulti3_out.mat');
	verifyEqual(testCase, act_out, testMulti3_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Multi3");
end
function test_blocklibsaturation(testCase)
    addpath("TestCases/Blocklib/MathOperations/atomic/Saturation");
	act_out = testSaturation();
	load('testSaturation_out.mat');
	verifyEqual(testCase, act_out, testSaturation_out)
	rmpath("TestCases/Blocklib/MathOperations/atomic/Saturation");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%QSS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_blocklibhIntegrator(testCase)
    addpath("TestCases/Blocklib/Qss/atomic/Hintegrator");
	act_out = testhIntegrator();
	load('testhIntegrator_out.mat');
	verifyEqual(testCase, act_out, testhIntegrator_out)
	rmpath("TestCases/Blocklib/Qss/atomic/Hintegrator");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Routing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_blocklibcombine3(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Combine3");
	act_out = testCombine3();
	load('testCombine3_out.mat');
	verifyEqual(testCase, act_out, testCombine3_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Combine3");
end
function test_blocklibcombine4(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Combine4");
	act_out = testCombine4();
	load('testCombine4_out.mat');
	verifyEqual(testCase, act_out, testCombine4_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Combine4");
end
function test_blocklibdistribute2(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Distribute2");
	act_out = testDistribute2();
	load('testDistribute2_out.mat');
	verifyEqual(testCase, act_out, testDistribute2_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Distribute2");
end
function test_blocklibdistribute3(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Distribute3");
	act_out = testDistribute3();
	load('testDistribute3_out.mat');
	verifyEqual(testCase, act_out, testDistribute3_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Distribute3");
end
function test_blocklibdistribute4(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Distribute4");
	act_out = testDistribute4();
	load('testDistribute4_out.mat');
	verifyEqual(testCase, act_out, testDistribute4_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Distribute4");
end
function test_blockliboutputswitch(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Outputswitch");
	act_out = testOutputswitch();
	load('testOutputswitch_out.mat');
	verifyEqual(testCase, act_out, testOutputswitch_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Outputswitch");
end
function test_blocklibsmallestin3(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Smallestin3");
	act_out = testSmallestin3();
	load('testSmallestin3_out.mat');
	verifyEqual(testCase, act_out, testSmallestin3_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Smallestin3");
end
function test_blocklibsmallestin4(testCase)
    addpath("TestCases/Blocklib/Routing/atomic/Smallestin4");
	act_out = testSmallestin4();
	load('testSmallestin4_out.mat');
	verifyEqual(testCase, act_out, testSmallestin4_out)
	rmpath("TestCases/Blocklib/Routing/atomic/Smallestin4");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Sinks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_blocklibtoworkspace(testCase)
    addpath("TestCases/Blocklib/Sinks/atomic/Toworkspace");
	act_out = testToworkspace();
	load('testToworkspace_out.mat');
	verifyEqual(testCase, act_out, testToworkspace_out)
	rmpath("TestCases/Blocklib/Sinks/atomic/Toworkspace");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Sources%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_blocklibfromworkspace(testCase)
    addpath("TestCases/Blocklib/Sources/atomic/Fromworkspace");
	act_out = testFromworkspace();
	load('testFromworkspace_out.mat');
	verifyEqual(testCase, act_out, testFromworkspace_out)
	rmpath("TestCases/Blocklib/Sources/atomic/Fromworkspace");
end
function test_blocklibGenerator(testCase)
    addpath("TestCases/Blocklib/Sources/atomic/Generator");
	act_out = testGenerator();
	load('testGenerator_out.mat');
	verifyEqual(testCase, act_out, testGenerator_out)
	rmpath("TestCases/Blocklib/Sources/atomic/Generator");
end
function test_blocklibvectorgen(testCase)
    addpath("TestCases/Blocklib/Sources/atomic/Vectorgen");
	act_out = testVectorgen();
	load('testVectorgen_out.mat');
	verifyEqual(testCase, act_out, testVectorgen_out)
	rmpath("TestCases/Blocklib/Sources/atomic/Vectorgen");
end
function test_blocklibbingenerator(testCase)
    addpath("TestCases/Blocklib/Sources/atomic/Bingenerator");
	act_out = testBingenerator();
	load('testBingenerator_out.mat');
	verifyEqual(testCase, act_out, testBingenerator_out)
	rmpath("TestCases/Blocklib/Sources/atomic/Bingenerator");
end
function test_blocklibConst(testCase)
    addpath("TestCases/Blocklib/Sources/atomic/Const");
	act_out = testConst();
	load('testConst_out.mat');
	verifyEqual(testCase, act_out, testConst_out)
	rmpath("TestCases/Blocklib/Sources/atomic/Const");
end
function test_blocklibenabledgenerator(testCase)
    addpath("TestCases/Blocklib/Sources/atomic/EnabledGenerator");
	act_out = testEnabledGenerator();
	load('testEnabledGenerator_out.mat');
	verifyEqual(testCase, act_out, testEnabledGenerator_out)
	rmpath("TestCases/Blocklib/Sources/atomic/EnabledGenerator");
end

%%%%%%%%%%%%%%%%%%%%Statistics%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%atomic
function test_blocklibutilization(testCase)
    addpath("TestCases/Blocklib/Statistics/atomic/Utilization");
	act_out = testUtilization();
	load('testUtilization_out.mat');
	verifyEqual(testCase, act_out, testUtilization_out)
	rmpath("TestCases/Blocklib/Statistics/atomic/Utilization");
end
function test_blocklibgetmax(testCase)
    addpath("TestCases/Blocklib/Statistics/atomic/Getmax");
	act_out = testGetmax();
	load('testGetmax_out.mat');
	verifyEqual(testCase, act_out, testGetmax_out)
	rmpath("TestCases/Blocklib/Statistics/atomic/Getmax");
end
%%coupled

%%%%%%%%%%%%%%%%%%%%Digital%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Converter
%atomic
function am_bin8_to_decblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Converter/atomic/Bin8_to_dec");
	act_out = test_am_bin8_to_dec();
	load('test_am_bin8_to_dec_out.mat');
	verifyEqual(testCase, act_out, test_am_bin8_to_dec_out)
	rmpath("TestCases/Blocklib/Digital/Converter/atomic/Bin8_to_dec");
end
function am_dec_to_bin8blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Converter/atomic/Dec_to_bin8");
	act_out = test_am_dec_to_bin8();
	load('test_am_dec_to_bin8_out.mat');
	verifyEqual(testCase, act_out, test_am_dec_to_bin8_out)
	rmpath("TestCases/Blocklib/Digital/Converter/atomic/Dec_to_bin8");
end
function am_bin_to_doubleblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Converter/atomic/Bin_to_double");
	act_out = test_am_bin_to_double();
	load('test_am_bin_to_double_out.mat');
	verifyEqual(testCase, act_out, test_am_bin_to_double_out)
	rmpath("TestCases/Blocklib/Digital/Converter/atomic/Bin_to_double");
end
%coupled

%%Logic
%atomic
function am_nand2blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/atomic/Nand2");
	act_out = test_am_nand2();
	load('test_am_nand2_out.mat');
	verifyEqual(testCase, act_out, test_am_nand2_out)
	rmpath("TestCases/Blocklib/Digital/Logic/atomic/Nand2");
end
function am_nand3blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/atomic/Nand3");
	act_out = test_am_nand3();
	load('test_am_nand3_out.mat');
	verifyEqual(testCase, act_out, test_am_nand3_out)
	rmpath("TestCases/Blocklib/Digital/Logic/atomic/Nand3");
end
function am_nand4blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/atomic/Nand4");
	act_out = test_am_nand4();
	load('test_am_nand4_out.mat');
	verifyEqual(testCase, act_out, test_am_nand4_out)
	rmpath("TestCases/Blocklib/Digital/Logic/atomic/Nand4");
end
function am_notgateblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/atomic/Not");
	act_out = test_am_not();
	load('test_am_not_out.mat');
	verifyEqual(testCase, act_out, test_am_not_out)
	rmpath("TestCases/Blocklib/Digital/Logic/atomic/Not");
end
function am_or2blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/atomic/Or2");
	act_out = test_am_or2();
	load('test_am_or2_out.mat');
	verifyEqual(testCase, act_out, test_am_or2_out)
	rmpath("TestCases/Blocklib/Digital/Logic/atomic/Or2");
end
%coupled
function cm_and2blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/And2");
	act_out = test_cm_and2();
	load('test_cm_and2_out.mat');
	verifyEqual(testCase, act_out, test_cm_and2_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/And2");
end
function cm_notblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Not");
	act_out = test_cm_not();
	load('test_cm_not_out.mat');
	verifyEqual(testCase, act_out, test_cm_not_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Not");
end
function cm_or2blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Or2");
	act_out = test_cm_or2();
	load('test_cm_or2_out.mat');
	verifyEqual(testCase, act_out, test_cm_or2_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Or2");
end
function cm_xor2blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Xor2");
	act_out = test_cm_xor2();
	load('test_cm_xor2_out.mat');
	verifyEqual(testCase, act_out, test_cm_xor2_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Xor2");
end
function cm_Mux2to1blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Mux2to1");
	act_out = test_cm_Mux2to1();
	load('test_cm_Mux2to1_out.mat');
	verifyEqual(testCase, act_out, test_cm_Mux2to1_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Mux2to1");
end
function cm_Mux4to1blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Mux4to1");
	act_out = test_cm_Mux4to1();
	load('test_cm_Mux4to1_out.mat');
	verifyEqual(testCase, act_out, test_cm_Mux4to1_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Mux4to1");
end
function cm_halfadderblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Halfadder");
	act_out = test_cm_halfadder();
	load('test_cm_halfadder_out.mat');
	verifyEqual(testCase, act_out, test_cm_halfadder_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Halfadder");
end
function cm_fulladderblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Fulladder");
	act_out = test_cm_fulladder();
	load('test_cm_fulladder_out.mat');
	verifyEqual(testCase, act_out, test_cm_fulladder_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Fulladder");
end
function cm_nand4blocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Nand4");
	act_out = test_cm_nand4();
	load('test_cm_nand4_out.mat');
	verifyEqual(testCase, act_out, test_cm_nand4_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Nand4");
end
function cm_rising_edgeblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Rising_edge");
	act_out = test_cm_rising_edge();
	load('test_cm_rising_edge_out.mat');
	verifyEqual(testCase, act_out, test_cm_rising_edge_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Rising_edge");
end
function cm_falling_edgeblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Falling_edge");
	act_out = test_cm_falling_edge();
	load('test_cm_falling_edge_out.mat');
	verifyEqual(testCase, act_out, test_cm_falling_edge_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Falling_edge");
end
function cm_carry_ripple_adder_8bitblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Carry_ripple_adder_8bit");
	act_out = test_cm_carry_ripple_adder_8bit();
	load('test_cm_carry_ripple_adder_8bit_out.mat');
	verifyEqual(testCase, act_out, test_cm_carry_ripple_adder_8bit_out)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Carry_ripple_adder_8bit");
end
%Model by Model verification
function MMVblocklib_not_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Not");
    addpath("TestCases/Blocklib/Digital/Logic/atomic/Not");
	out_cm = test_cm_not();
	out_am = test_am_not();
	verifyEqual(testCase, out_cm, out_am)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Not");
    rmpath("TestCases/Blocklib/Digital/Logic/atomic/Not");
end
function MMVblocklib_or2_test(testCase)
    addpath("TestCases/Blocklib/Digital/Logic/coupled/Or2");
    addpath("TestCases/Blocklib/Digital/Logic/atomic/Or2");
	out_cm = test_cm_or2();
	out_am = test_am_or2();
	verifyEqual(testCase, out_cm, out_am)
	rmpath("TestCases/Blocklib/Digital/Logic/coupled/Or2");
    rmpath("TestCases/Blocklib/Digital/Logic/atomic/Or2");
end

%%Flip Flops
%atomic
function am_jk_flip_flopblocklib_test(testCase)
    addpath("TestCases/Blocklib/Digital/FlipFlops/JK/atomic/JKFF");
	act_out = test_am_jk_flip_flop();
	load('test_am_jk_flip_flop_out.mat');
	verifyEqual(testCase, act_out, test_am_jk_flip_flop_out)
	rmpath("TestCases/Blocklib/Digital/FlipFlops/JK/atomic/JKFF");
end
%coupled

%Model by Model verification
