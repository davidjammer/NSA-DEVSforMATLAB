function AddN_Model = build_AddN_Model(name, N)
  % manual cm model with addN + N const components
  % N:    number of inputs

  AddN_Model = coordinator(name);

  % create atomics
  atomic_am_addN = am_addN("am_addN",N,[0,1],0);
  for I=1:N
    atomic_am_const(I) = am_const("am_const"+I, I,[I,0],0);
  end
  atomic_am_toworkspace = am_toworkspace("am_toworkspace","sum",0,"vector",[0,5],0);

  % add atomics to simulators
  devs_am_addN = devs(atomic_am_addN);
  for I=1:N
    devs_am_const(I) = devs(atomic_am_const(I));
  end
  devs_am_toworkspace = devs(atomic_am_toworkspace);

  % add simulators and models to coordinator
  AddN_Model.add_model(devs_am_addN);
  for I=1:N
    AddN_Model.add_model(devs_am_const(I));
  end
  AddN_Model.add_model(devs_am_toworkspace);

  % add couplings
  AddN_Model.add_coupling("am_addN","out","am_toworkspace","in");
  for I=1:N
    AddN_Model.add_coupling("am_const"+I,"out","am_addN","in"+I);
  end
end
