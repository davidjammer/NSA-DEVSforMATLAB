function runTestFurnace(type, set)
  % makes and runs model and plots results
  % parameters:
  %   type    "HF" or "TF"
  %   set     1, 2, 3
  % optional:
  %   set global DEBUGLEVEL
  %   model_simulator(model, tEnd, false)
  if nargin == 0
    type = "HF";
    set = 1;
  end

  model = "testFurnace";
  addpath("atomics");

  if type == "HF"
    params.tNew = 500;
    switch set
      case 1
        params.PH = 6400; % Watt
        params.Co = 6000; % J/K
        params.k_A = 6; % Watt/K
        params.Te = 25; % Celsius
        params.P0 = 2000; % Watt
        params.P_unload = 60000; % Watt
        params.holding_time = 1800*3;
        params.Tsoll = 800;
        params.Kapa = 20;
        params.nIn = 80;
        tEnd = 40000;
      case 2
        params.PH = 15000; % Watt
        params.Co = 10000; % J/K
        params.k_A = 8; % Watt/K
        params.Te = 25; % Celsius
        params.P0 = 2000; % Watt
        params.P_unload = 100000; % Watt
        params.holding_time = 1800*3;
        params.Tsoll = 800;
        params.Kapa = 40;
        params.nIn = 160;
        tEnd = 80000;
      case 3
        params.PH = 20000; % Watt
        params.Co = 12000; % J/K
        params.k_A = 10; % Watt/K
        params.Te = 25; % Celsius
        params.P0 = 2000; % Watt
        params.P_unload = 120000; % Watt
        params.holding_time = 1800*3;
        params.Tsoll = 800;
        params.Kapa = 70;
        params.nIn = 280;
        tEnd = 120000;
    end
  else   % type = "TF"
    params.tNew = 900;
    switch set
      case 1
        params.PH = 6400; %in Watt
        params.Co = 6000; %in J/K
        params.k_A = 6; %Watt/K
        params.Te = 25; %Celsius
        params.P0 = 2000; %in Watt
        params.P_unload = 25000; %in Watt
        params.holding_time = 3600*3;
        params.Tsoll = 400;
        params.Kapa = 20;
        params.nIn = 80;
        tEnd = 80000;
      case 2
        params.PH = 15000; %in Watt
        params.Co = 10000; %in J/K
        params.k_A = 8; %Watt/K
        params.Te = 25; %Celsius
        params.P0 = 2000; %in Watt
        params.P_unload = 40000; %in Watt
        params.holding_time = 3600*3;
        params.Tsoll = 400;
        params.Kapa = 40;
        params.nIn = 160;
        tEnd = 120000;
      case 3
        params.PH = 20000; %in Watt
        params.Co = 12000; %in J/K
        params.k_A = 10; %Watt/K
        params.Te = 25; %Celsius
        params.P0 = 2000; %in Watt
        params.P_unload = 50000; %in Watt
        params.holding_time = 3600*3;
        params.Tsoll = 400;
        params.Kapa = 70;
        params.nIn = 280;
        tEnd = 190000;
    end
  end

  tEnd = 1.5*tEnd;   % should be ready then

  load_system(model);
  set_param("testFurnace/am_enabledgenerator", "tG", string(params.tNew), ...
             "nG", string(params.nIn))
  hBlock = getSimulinkBlockHandle("testFurnace/furnace", true);
  set_param(hBlock, "PH", string(params.PH))
  set_param(hBlock, "Co", string(params.Co))
  set_param(hBlock, "k_A", string(params.k_A))
  set_param(hBlock, "Te", string(params.Te))
  set_param(hBlock, "P0", string(params.P0))
  set_param(hBlock, "P_unload", string(params.P_unload))
  set_param(hBlock, "holding_time", string(params.holding_time))
  set_param(hBlock, "Tsoll", string(params.Tsoll))
  set_param(hBlock, "Kapa", string(params.Kapa))
  %save_system(model)

  model_generator(model);

  out = model_simulator(model, tEnd);
  plotResults(out, tEnd)
  rmpath("atomics");
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
  figure("name", "Count")
  stem(out.FIFO_n.t, out.FIFO_n.y)
  hold("on")
  stem(out.Term_n.t, [out.Term_n.y])
  hold("off")
  xlim([0 tEnd]);
  title("entities");

  figure("name", "testFurnace", "NumberTitle", "off",...
         "Position", [1 1 500 750]);
  subplot(4,1,1)
  stairs(out.T.t, out.T.y)
  ylabel("T [°C]");
  xlabel("t [s]");
  title("Temperature");
  xlim([0 tEnd]);
  ylim([0 1.1*max(out.T.y)]);

  subplot(4,1,2)
  stairs(out.P.t, out.P.y)
  ylabel("P [kW]");
  xlabel("t [s]");
  title("Power");
  xlim([0 tEnd]);
  ylim([0 1.1*max(out.P.y)]);

  subplot(4,1,3)
  stairs(out.E.t, out.E.y)
  ylabel("E [kWh]");
  xlabel("t [s]");
  xlim([0 tEnd]);
  title("Energy");

  subplot(4,1,4)
  cats = ["load", "heatup", "hold", "unload"];
  ph = categorical(out.phase.y, cats, "Ordinal", true);
  stairs(out.phase.t, ph);
  title("Phase");
  xlabel("t [s]");
  xlim([0 tEnd]);
end
