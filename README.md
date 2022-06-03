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

E.g.: Generator1 = devs(generator('Generator',1.0, [0, 1]));

Generator1 is now a DEVS simulator associated with the atomic model generator.

To create a coupled model, an object of class coordinator is instantiated:
E.g.: N1 = coordinator('N1');

The simulators with their associated models can now be added to the N1 coordinator:

E.g.: N1.add_model(Generator1);

To add couplings to a coordinator, the method add_coupling('from model', 'from port', 'to model', 'to port') is used:

E.g.: N1.add_coupling('Generator1','out','Pipe1','in');

A root coordinator must be created as the topmost instance.
The following is passed to this root coordinator:

- Name
- Simulation start time
- Simulation end time
- Top coordinator
- 0 or 1 for stepping mode

E.g.: root = rootcoordinator('root',tstart,tend,N1,0);

To start the simulation, the sim method is used:

root.sim();

To log simulation results, the global variable simout and the atomic model toworkspace can be used.

To get started, you can use the simulations from the Examples directory (model1.m, ..., model5.m) and the models from the Modelbase directory.
