function CollectN_Model = build_CollectN_Model(name, N)
  % manual cm model with addN + N const components
  % N:    number of inputs

  CollectN_Model = coordinator(name);

  % create atomics
  atomic_am_collectN = am_collectN("am_collectN",N,[0,2],[0,1],0);
  for I=1:N
    atomic_am_generator(I) = am_generator("am_generator"+I,I, 10*I-9,Inf,[0,2],0);
  end
  atomic_am_toworkspace = am_toworkspace("am_toworkspace","combOut",...
    0,"vector",[0,1],0);
  
  % add atomics to simulators
  devs_am_collectN = devs(atomic_am_collectN);
  for I=1:N
    devs_am_generator(I) = devs(atomic_am_generator(I));
  end
  devs_am_toworkspace = devs(atomic_am_toworkspace);

  % add simulators and models to coordinator
  CollectN_Model.add_model(devs_am_collectN);
  for I=1:N
    CollectN_Model.add_model(devs_am_generator(I));
  end
  CollectN_Model.add_model(devs_am_toworkspace);

  % add couplings
  CollectN_Model.add_coupling("am_collectN","out","am_toworkspace","in");
  for I=1:N
    CollectN_Model.add_coupling("am_generator"+I,"out","am_collectN","in"+I);
  end
end
