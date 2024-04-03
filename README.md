# NSA-DEVSforMATLAB

A simulator for NSA-DEVS (Non-Standard Analysis Discrete Event System Specification) in the Matlab environment.

* Dependencies: Sequence Diagram tool (https://de.mathworks.com/matlabcentral/fileexchange/12560-sequence-diagram-tool)

## How to use:
To create an atomic model, a class must be created that has the properties: 

* tau (input delay time)
* s (state) 
* name (name of the model). 


Besides these properties, the class can have other properties.
The class must have the following methods: 

* function delta(obj) -> Transfer function
* function y=lambda(obj) -> Output function
* function t = ta(obj) -> Time advance function

The class of the simulator is called devs. The atomic model must be associated with a simulator:

E.g.: Generator = devs(am_generator('Generator',1.0, 1, 100, [0, 1], 0));

Generator is now a DEVS simulator associated with the atomic model generator.

To create a coupled model, an object of class coordinator is instantiated:
E.g.: N1 = coordinator('N1');

The simulators with their associated models can now be added to the N1 coordinator:

E.g.: N1.add_model(Generator);

To add couplings to a coordinator, the method add_coupling('from model', 'from port', 'to model', 'to port') is used:

E.g.: N1.add_coupling('Generator','out','Terminator','in');

A root coordinator must be created as the topmost instance.
The following is passed to this root coordinator:

- Name
- Simulation start time
- Simulation end time
- Top coordinator
- 0 or 1 for stepping mode
- 0 or 1 to show the time progress

E.g.: root = rootcoordinator('root',tstart,tend,N1,0,1);

To start the simulation, the sim method is used:

root.sim();

To log simulation results, the global variable simout and the atomic model toworkspace can be used.

To get started, you can use the simulations from the Examples directory (BigExample, C22, PaperExample) and the models from the Modelbase directory.

The Simulink environment can be used for more user-friendly modeling.
The Simulink library NSA-DEVS can be used for this.
After modeling, an NSA-DEVS model can be generated automatically via the model generator.
The model_generator function is used for this.
The model_simulator function can be used to start the simulation.