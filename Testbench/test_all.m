function tests = test_all
  % Run all tests with
  %     run(test_all)
  tests = test_atomics;
  tests = [tests, test_blocklib];
  tests = [tests, test_examples];
end
