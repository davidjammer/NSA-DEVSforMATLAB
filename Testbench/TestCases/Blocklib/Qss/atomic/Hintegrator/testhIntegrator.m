function [out] = testhIntegrator()

	tend = 10;
	model_generator("Hintegrator_Model");
	out = model_simulator("Hintegrator_Model", tend);

    if 0
        figure
        stairs(out.gen1Out.t,out.gen1Out.y); hold on;
        stairs(out.hIntOut.t,out.hIntOut.y); hold off;
    end
end
