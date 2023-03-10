function model_generator(fileName, modelName, libFile, atomic_names, coupled_names, parameterList)
%model_generator(fileName, modelName, libFile, atomic_names, coupled_names)
%generiert (hoffentlich) aus einem in Simulink erstellten Modell den für
%die Ausführung dieses Modells im NSA-DEVSforMATLAB-Simulator
%erforderlichen MATLAB-Programmcode
%
%   fileName:   Simulink-Modelldatei (.slx) des zu simulierenden Modells
%
%   modelName:  Name der auszugebenden Datei, die das root-Modell enthält 
%               z.B. wird bei Übergabe des Strings "test" die Datei
%               "build_test.m" erstellt.
%
%   libFile:    Simulink Bibliotheksdatei(en) (.slx), die die Atomics und
%               gekoppelten Atomics enthält. Übergabe mehrere
%               Bibliotheksdateien als Vektor.
%
%   atomic_names:   Nicht für initialen Aufruf nötig. Wird nur bei
%                   rekursiven Aufrufen innerhalb der Funktion gesetzt
%
%   coupled_names:  wie atomic_names

%% Verzeichnisse erstellen, Dateien entpacken
% Ausgabeverzeichnis erstllen
if ~exist("./out", "dir")
    mkdir("out");
end

% Klassendateien für alle Atomics und build-Dateien für die gekoppelten
% Atomics erstellen
if nargin < 4
    atomic_names = [];
    coupled_names = [];
    for lib = libFile
        [new_atomic_names, new_coupled_names, coupled_to_build] = generate_atomics(lib, pwd + "/out");
        atomic_names = [atomic_names, new_atomic_names];
        coupled_names = [coupled_names, new_coupled_names];
    end
    clearvars new_atomic_names new_coupled_names; % weniger Variablen machen Debugging überschaubarer

    cd("./out");
    for model = flatten(coupled_to_build)
        model = model{1};
        build_coupled_devs(model.libraryPath, model.xml, model.coupled_atomics_sids, model.coupled_atomics, model.libName)
        rmdir(model.libName, "s");
    end
    cd(".."); 
end

% Simulink Modelldatei entpacken (wird zum Schluss wieder gelöscht)
if endsWith(fileName, ".slx")
    % entpacke .slx in gleichnamiges Verzeichnis im out-Verzeichnis
    dirName = strsplit(fileName, ".");
    dirName = dirName(end-1).split("/");
    path = "./out/" + dirName(end) + "/simulink/systems";
    unzip(fileName, "./out/" + dirName(end));
    fileName = "system_root.xml"; % Model beginnt immer bei system_root.xml
% Im Fall eines rekursiven Aufrufs den Pfad und Dateinamen aus dem
% absoluten Pfad des übergebenen Dateinamens holen
else
    [path, fileName, ext] = fileparts(fileName);
    fileName = fileName + ext;
    clearvars ext;
end

%% XML einlesen, Instanzen der Atomics erzeugen
xml = readstruct(path + "/" + fileName);

% Liste über atomics und coupled-models führen, da mehrfach über diese
% iteriert werden muss.
atomics = {};           % Einfache Atomics
subsystems = {};        % Subsysteme im Modell
coupled_atomics = {};   % Atomics, die aus anderen Atomics zusammengesetzt wurden

% Über alle Blöcke der XML-Datei iterieren und anhand des Blocktyps ein
% entsprechendes Objekt mit Hilfe der Atomic-Klassendateien erzeugen.
% Diese dann der Liste über alle Atomics bzw. coupled-models hinzufügen
for block = xml.Block
    % Ein Block vom Typ Reference sollte immer auf ein Atomic aus der
    % Bibliotheksdatei verweisen
    if block.BlockTypeAttribute == "Reference"
        for p = block.P
            if p.NameAttribute == "SourceBlock"
                atomic_type = split(p.Text, '/');
                atomic_library = atomic_type(1);
                atomic_type = atomic_type(end);
                % Objekt instanziieren und der Liste hinzufügen
                if ismember(atomic_type, atomic_names)
                    atomics{end+1} = feval(atomic_type + "_" + atomic_library, block);
                elseif ismember(atomic_type, coupled_names)
                    coupled_atomics{end+1} = feval(atomic_type + "_" + atomic_library, block);
                end
            end
        end
    % Blöcke vom Typ In-, Outport oder Subsystem unterscheiden sich etwas
    % von den Atomics. Für sie gibt es eine einmalig erzeugte Klassendatei.
    elseif block.BlockTypeAttribute == "Inport" || block.BlockTypeAttribute == "Outport"
        atomics{end+1} = inoutPort(block.SIDAttribute, modelName, block.NameAttribute);
    % Subsystem-Blöcke brauchen zusätzlich den Pfad, da zum Feststellen der
    % Portnamen die XML-Datei des Systems eingelesen werden muss. Außerdem
    % wird ihrem Namen der Name des übergeordneten Models vorangestellt,
    % damit es nicht zur Namenskollision kommt, wenn mehrere Subsysteme
    % wiederum Subsysteme mit identischem Namen enthalten.
    elseif block.BlockTypeAttribute == "SubSystem"
        % Prüfe, ob Subsystem Parameter hat (Mask-Parameter)
        if any(contains(fieldnames(block), 'Mask'))
            parameter_list = string([]);
			for parameter = block.Mask.MaskParameter
				parameter_list(end+1) = parameter.NameAttribute;
			end
        end
        if exist("parameter_list", "var")
            model_generator(path + "/" + block.System.RefAttribute + ".xml",...
                modelName + "_" + block.NameAttribute, libFile, atomic_names, coupled_names, parameter_list);
        else
            model_generator(path + "/" + block.System.RefAttribute + ".xml",...
                modelName + "_" + block.NameAttribute, libFile, atomic_names, coupled_names);
        end
        subsystems{end+1} = modelName + "_" + block.NameAttribute;
        atomics{end+1} = subsystem1(block, path, modelName);
    end
end

%% MATLAB-Programmcode erzeugen

% Öffne Datei für Modellerzeugung
f = fopen("./out/build_" + modelName + ".m", "w");

% Funktionskopf
if exist('parameterList', 'var') && ~isempty(parameterList)
    fprintf(f, "function [%s] = build_%s(", modelName, modelName);
    for k = 1:length(parameterList)
        if k == length(parameterList)
            fprintf(f, "%s)\n", parameterList(k));
        else
            fprintf(f, "%s,", parameterList(k));
        end
    end
else
    fprintf(f, "function [%s] = build_%s()\n", modelName, modelName);
end

% Aufruf coordinator()
fprintf(f, '\n%s = coordinator("%s");\n', modelName, modelName);

%% Abschnitt: create atomics
% Schreibe immer: atomic_NAME = CONSTRUCTOR()
fprintf(f, "\n%% create atomics\n");
for atomic = atomics
    atomic = atomic{1};
    % in-/outports und Subsysteme sind natürlich keine atomics, befinden
    % sich aber in derselben Liste
    if ~any(contains(methods(atomic), "inoutPort")) && ~any(contains(methods(atomic), "subsystem"))
        fprintf(f, "atomic_%s = %s;\n", atomic.name, atomic.getConstructor());
    end
end

%% Abschnitt: add atomics to simulators
% Schreibe immer: devs_NAME = devs(atomic_NAME)
fprintf(f, "\n%% add atomics to simulators\n");
for atomic = atomics
    atomic = atomic{1};
    % in-/outports wieder auslassen
    if ~any(contains(methods(atomic), "inoutPort")) && ~any(contains(methods(atomic), "subsystem"))
        fprintf(f, "devs_%s = devs(atomic_%s);\n", atomic.name, atomic.name);
    end
end

%% Abschnitt: create coupled models
% Schreibe immer: MODELNAME = build_MODELNAME()
fprintf(f, "\n%% create coupled models\n");
if ~isempty(subsystems) || ~isempty(coupled_atomics)
    % Für jedes Subsystem...
    for atomic = atomics
        atomic = atomic{1};
        if class(atomic) == "subsystem1"
            fprintf(f, "%s = build_%s(", atomic.name, atomic.name);
            if length(atomic.parameter) > 0
                for k = 1:length(atomic.parameter)
                    parameter_name = fieldnames(atomic.parameter{k});
                    parameter_name = parameter_name{1};
                    if k == length(atomic.parameter)
                        fprintf(f, "%s);\n", string(atomic.parameter{k}.(parameter_name)));
                    else
                        fprintf(f, "%s,", string(atomic.parameter{k}.(parameter_name)));
                    end
                end
            else
                fprintf(f, ");\n");
            end
        end
    end
    % ... und für jedes zusammengesetzte Atomic
    for coupled_atomic = coupled_atomics
        coupled_atomic = coupled_atomic{1};
        % Modifiziere Konstruktor: c() -> c_libName(), falls mehrere
        % Atomic-Bibliotheken verwendet wurden und diese Atomics mit
        % gleichem Namen enthalten (falls es diesen Fall überhaupt gibt)
        newConstructor = extractBefore(coupled_atomic.getConstructor(), "(") ...
            + "_" + coupled_atomic.libName;
        parameter = extractAfter(coupled_atomic.getConstructor(), "(");
        fprintf(f, "%s = build_%s(%s;\n", coupled_atomic.name, ...
            newConstructor, parameter);
    end
    clearvars newConstructor subsystem;
end


%% Abschnitt: add simulators and models to coordinator
% Schreibe immer: MODELNAME.add_model(devs_NAME oder coupled-model-Name)
% Für jedes Atomic, zusammengesetzte Atomic und Subsystem
fprintf(f, "\n%% add simulators and models to coordinator\n");
for atomic = atomics
    atomic = atomic{1};
    % in-/outports auslassen
    if ~any(contains(methods(atomic), "inoutPort")) && ~any(contains(methods(atomic), "subsystem"))
        fprintf(f, "%s.add_model(devs_%s);\n", modelName, atomic.name);
    end
end
for subsystem = subsystems
    subsystem = subsystem{1};
    fprintf(f, "%s.add_model(%s);\n", modelName, subsystem);
end
for coupled_atomic = coupled_atomics
    coupled_atomic = coupled_atomic{1};
    fprintf(f, "%s.add_model(%s);\n", modelName, coupled_atomic.name);
end
clearvars atomic subsystem coupled_atomic;

%% Abschnitt: add couplings
% Schreibe: MODELNAME.add_coupling(Atomic-Name oder coupled-model-Name,
% Quellport-name, Ziel-Atomic-Name oder coupled-model-Name, Zielport-Name)
fprintf(f, "\n%% add couplings\n");
% Jedes Line-Elemente stellte eine Verbindung von Quelle-->Ziel dar, kann
% sich jedoch in mehrere Branches aufteilen, sodass Quelle-->Ziel1,
% Quelle-->Ziel2, ...
for line = xml.Line
    % 1. Möglichkeit: Die Linie teilt sich nicht (kein Branch)
    if ~any(contains(fieldnames(line), "Branch"))
        for pNr = 1:length(line.P)
            if line.P(pNr).NameAttribute == "Src"
                srcSid = split(line.P(pNr).Text, '#');
                srcSid = srcSid(1);
                srcPortNr = split(line.P(pNr).Text, ':');
                srcPortNr = double(srcPortNr(2));
            elseif line.P(pNr).NameAttribute == "Dst"
                dstSid = split(line.P(pNr).Text, '#');
                dstSid = dstSid(1);
                dstPortNr = split(line.P(pNr).Text, ':');
                dstPortNr = double(dstPortNr(2));
            end
        end
        % Namen von Quell- und Zielkomponente bestimmten
        for k = 1:length(atomics)
            if atomics{k}.sid == double(srcSid)
                srcName = atomics{k}.name;
                srcPortName = atomics{k}.getOutportName(srcPortNr);
            elseif atomics{k}.sid == double(dstSid)
                dstName = atomics{k}.name;
                dstPortName = atomics{k}.getInportName(dstPortNr);
            end
        end
        for k = 1:length(coupled_atomics)
            if coupled_atomics{k}.sid == double(srcSid)
                srcName = coupled_atomics{k}.name;
                srcPortName = coupled_atomics{k}.getOutportName(srcPortNr);
            elseif coupled_atomics{k}.sid == double(dstSid)
                dstName = coupled_atomics{k}.name;
                dstPortName = coupled_atomics{k}.getInportName(dstPortNr);
            end
        end
        % Zeile schreiben
        fprintf(f, '%s.add_coupling("%s","%s","%s","%s");\n', ...
            modelName, srcName, srcPortName, dstName, dstPortName);
    % 2. Möglichkeit: Ebenfalls keine Branches, aber die Matlab-Struktur
    % enthält u. U. trotzdem das Feld "Branch", da möglicherweise andere
    % Line-Elemente einen Branch beinhalten. Nur die if-Abfrage ändert
    % sich.
    elseif ismissing(line.Branch)
        for pNr = 1:length(line.P)
            if line.P(pNr).NameAttribute == "Src"
                srcSid = split(line.P(pNr).Text, '#');
                srcSid = srcSid(1);
                srcPortNr = split(line.P(pNr).Text, ':');
                srcPortNr = double(srcPortNr(2));
            elseif line.P(pNr).NameAttribute == "Dst"
                dstSid = split(line.P(pNr).Text, '#');
                dstSid = dstSid(1);
                dstPortNr = split(line.P(pNr).Text, ':');
                dstPortNr = double(dstPortNr(2));
            end
        end
        % Namen von Quell- und Zielkomponente bestimmten
        for k = 1:length(atomics)
            if atomics{k}.sid == double(srcSid)
                srcName = atomics{k}.name;
                srcPortName = atomics{k}.getOutportName(srcPortNr);
            elseif atomics{k}.sid == double(dstSid)
                dstName = atomics{k}.name;
                dstPortName = atomics{k}.getInportName(dstPortNr);
            end
        end
        for k = 1:length(coupled_atomics)
            if coupled_atomics{k}.sid == double(srcSid)
                srcName = coupled_atomics{k}.name;
                srcPortName = coupled_atomics{k}.getOutportName(srcPortNr);
            elseif coupled_atomics{k}.sid == double(dstSid)
                dstName = coupled_atomics{k}.name;
                dstPortName = coupled_atomics{k}.getInportName(dstPortNr);
            end
        end
        fprintf(f, '%s.add_coupling("%s","%s","%s","%s");\n', ...
            modelName, srcName, srcPortName, dstName, dstPortName);
    % 3. Möglichkeit: Branches existieren
    else
        % Es gibt immer nur ein Qeull-Element, aber beliebig verschachtelte
        % Branches mit verschiedenen Zielen. Daher erst einmal das
        % Quellkomponente bestimmen, dann alle Branches abarbeiten.
        for pNr = 1:length(line.P)
            if line.P(pNr).NameAttribute == "Src"
                srcSid = split(line.P(pNr).Text, '#');
                srcSid = srcSid(1);
                srcPortNr = split(line.P(pNr).Text, ':');
                srcPortNr = double(srcPortNr(2));
            end
        end
        % Branches können beliebig tief verzweigt sein, was sich gut durch
        % Rekursion abarbeiten lässt. Daher hierzu eine eigene Funktion.
        printBranches(f, line, srcSid, srcPortNr, atomics, coupled_atomics, modelName);
    end
end

fprintf(f, "\nend");
fclose(f);

%% Aufräumen
% Verzeichnis mit entpackten Dateien löschen
if nargin < 4
    rmdir("./out/" + dirName(end), "s");
end
end

function [flat] = flatten(to_build)
structs = {};
for k = 1:length(to_build)
    elem = to_build{k};
    if isstruct(elem)
        structs{end+1} = elem;
    else
        for s = flatten(elem)
            structs = [structs, s];
        end
    end
end
flat = structs;
end