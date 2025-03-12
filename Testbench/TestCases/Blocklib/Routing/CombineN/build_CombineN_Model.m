function CombineN_Model = build_CombineN_Model(name, N)
  % manual cm model with addN + N const components
  % N:    number of inputs

  CombineN_Model = coordinator(name);

  % create atomics
  atomic_am_combineN = am_combineN("am_combineN",N,[0,2],[0,1],0);
  for I=1:N
    atomic_am_generator(I) = am_generator("am_generator"+I,I, 10*I-9,Inf,[0,2],0);
  end
  atomic_am_toworkspace = am_toworkspace("am_toworkspace","combOut",...
    0,"vector",[0,1],0);
  
  % add atomics to simulators
  devs_am_combineN = devs(atomic_am_combineN);
  for I=1:N
    devs_am_generator(I) = devs(atomic_am_generator(I));
  end
  devs_am_toworkspace = devs(atomic_am_toworkspace);

  % add simulators and models to coordinator
  CombineN_Model.add_model(devs_am_combineN);
  for I=1:N
    CombineN_Model.add_model(devs_am_generator(I));
  end
  CombineN_Model.add_model(devs_am_toworkspace);

  % add couplings
  CombineN_Model.add_coupling("am_combineN","out","am_toworkspace","in");
  for I=1:N
    CombineN_Model.add_coupling("am_generator"+I,"out","am_combineN","in"+I);
  end
end
