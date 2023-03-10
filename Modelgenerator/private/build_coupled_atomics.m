function build_coupled_atomics(library_path, root_xml, coupled_models_sids, coupled_atomic_names, libName)
%Erzeugt die build_xxx-Dateien für gekoppelte Atomics.
%
%   library_path: Pfad zu den entpackten XML-Dateien der Atomic-Bibliothek
%
%   root_xml:   Struct mit Inhalt der system_root.xml der Bibliothek
%
%   coupled_models_sids: SIDs der gekoppelten Atomics
%
%   coupled_atomic_names: Namen der gekoppelten Atomics
%
%   libName: Name der Bibliotheksdatei

if ~exist("coupled", "dir")
    mkdir("./coupled");     % Hier werden die Build-Dateien abgelegt
end
addpath("./coupled");
outPath = "./coupled/";

% Variablen
atomic_name = 0;            % Name der Komponente
atomic_parameter = 0;       % Konstruktor-Parameter
f = 0;                      % File Descriptor
xml = 0;                    % XML des Coupled Atomic

sub_atomics = {};           % einfache Atomics in den einzelnen Atomics
coupled_sub_atomics = {};   % Atomics, die aus weiteren Atomics bestehen
  
for sid = coupled_models_sids
    % Erstelle Build-Datein
    for block = root_xml.Block
        if block.SIDAttribute == sid
            % Die relevanten Daten sind in block.Mask.MaskParameter zu finden
            % Für die erste Zeile wird der Konstructor benötigt
            for parameter = block.Mask.MaskParameter
                if parameter.NameAttribute == "constructor"
                    % Hole den Namen des Atomics aus der Zeichenkette
                    atomic_name = split(erase(parameter.Value, "'"), "(");
                    atomic_name = atomic_name(1);

                    % Hole Konstruktor-Parameter
                    atomic_parameter = split( erase(parameter.Value, "'"), "(");
                    atomic_parameter = erase( erase( split(atomic_parameter(2), ","), '"'), ")");

%% Datei schreiben
                    % Öffne Datei und schreibe erste Zeile
                    f = fopen(outPath + "build_" + atomic_name + "_" + libName + ".m", "w");
                    fprintf(f, "function [%s] = build_%s_%s(", atomic_name, atomic_name, libName);
                    for k = 1:length(atomic_parameter)
                        if k == length(atomic_parameter)
                            fprintf(f, "%s", atomic_parameter(k));
                        else
                            fprintf(f, "%s, ", atomic_parameter(k));
                        end
                    end
                    fprintf(f, ")\n\n");

                    % Schreibe ... = coordinator(name)
                    fprintf(f, "%s = coordinator(name);\n\n", atomic_name);

                    % XML-Datei des Atomic einlesen
                    xml = readstruct(library_path + "system_" + sid + ".xml");

                    % Ab hier sollte es ähnlich wie in der
                    % model_generator-Funtkion laufen. Allerdings enthält
                    % ein Atomic höchstens In-OutPorts und weitere Atomics,
                    % keine Subsysteme, jedoch gekoppelte Atomics

                    % Über Blocke der XML-Datei iterieren
                    for atomic_block = xml.Block
                        if atomic_block.BlockTypeAttribute == "Reference"
                            for p = atomic_block.P
                                if p.NameAttribute == "SourceBlock"
                                    atomic_type = split(p.Text, "/");
                                    if atomic_type(1) ~= "$bdroot"
                                        atomic_lib = atomic_type(1);
                                    else
                                        atomic_lib = libName;
                                    end
                                    atomic_type = atomic_type(2);
                                    % Objekt instanziieren und der Liste hinzufügen
                                    if any(atomic_type == coupled_atomic_names)
                                        coupled_sub_atomics{end+1} = feval(atomic_type + "_" + atomic_lib, atomic_block);
                                    else
                                        sub_atomics{end+1} = feval(atomic_type + "_" + atomic_lib, atomic_block);
                                    end
                                end
                            end
                    	elseif atomic_block.BlockTypeAttribute == "Inport" || atomic_block.BlockTypeAttribute == "Outport"
                            sub_atomics{end+1} = inoutPort(atomic_block.SIDAttribute, atomic_name, atomic_block.NameAttribute);
                        end
                    end


                    %% create atomics
                    fprintf(f, "%% create atomics\n");
                    for atomic = sub_atomics
                        atomic = atomic{1};
                        % in-/outports und Subsysteme sind natürlich keine atomics
                        if ~any(contains(methods(atomic), "inoutPort")) && ~any(contains(methods(atomic), "subsystem"))
                            fprintf(f, "atomic_%s = %s;\n", atomic.name, atomic.getConstructor());
                        end
                    end

                    %% add atomics to simulators
                    fprintf(f, "\n%% add atomics to simulators\n");
                    for atomic = sub_atomics
                        atomic = atomic{1};
                        if ~any(contains(methods(atomic), "inoutPort")) && ~any(contains(methods(atomic), "subsystem"))
                            fprintf(f, "devs_%s = devs(atomic_%s);\n", atomic.name, atomic.name);
                        end
                    end

                    %% create coupled models
                    if ~isempty(coupled_sub_atomics)
                        fprintf(f, "\n%% create coupled models\n");
                        % Für jedes zusammengesetzte Atomic
                        for coupled_sub_atomic = coupled_sub_atomics
                            coupled_sub_atomic = coupled_sub_atomic{1};
                            newConstructor = extractBefore(coupled_sub_atomic.getConstructor(), "(") ...
                                + "_" + coupled_sub_atomic.libName;
                            parameter = extractAfter(coupled_sub_atomic.getConstructor(), "(");
                            fprintf(f, "%s = build_%s(%s;\n", coupled_sub_atomic.name, newConstructor, parameter);
                        end
                    end

                    %% add simulators and models to coordinator
                    fprintf(f, "\n%% add simulators and models to coordinator\n");
                    for sub_atomic = sub_atomics
                        sub_atomic = sub_atomic{1};
                        if ~any(contains(methods(sub_atomic), "inoutPort"))
                            fprintf(f, "%s.add_model(devs_%s);\n", atomic_name, sub_atomic.name);
                        end
                    end
                    for coupled_sub_atomic = coupled_sub_atomics
                        coupled_sub_atomic = coupled_sub_atomic{1};
                        fprintf(f, "%s.add_model(%s);\n", atomic_name, coupled_sub_atomic.name);
                    end

                    %% add couplings
                    % Besonderheit hier: Statt den Namen des Atomic, dessen
                    % Build-Datei hier erstellt wird, zu schreiben, wird 
                    % einfach "name" geschrieben (ohne Anführungszeichen)
                    fprintf(f, "\n%% add couplings\n");
                    for line = xml.Line
                        % 1. Möglichkeit: Die Linie teilt sich nicht (kein Branch)
                        if ~any(contains(fieldnames(line), "Branch"))
                            for p = line.P
                                if p.NameAttribute == "Src"
                                    srcSid = split(p.Text, '#');
                                    srcSid = srcSid(1);
                                    srcPortNr = split(p.Text, ':');
                                    srcPortNr = double(srcPortNr(2));
                                elseif p.NameAttribute == "Dst"
                                    dstSid = split(p.Text, '#');
                                    dstSid = dstSid(1);
                                    dstPortNr = split(p.Text, ':');
                                    dstPortNr = double(dstPortNr(2));
                                end
                            end
                            % Namen von Quell- und Zielkomponente bestimmten
                            for sub_atomic = sub_atomics
                                sub_atomic = sub_atomic{1};
                                if sub_atomic.sid == double(srcSid)
                                    srcName = sub_atomic.name;
                                    srcPortName = sub_atomic.getOutportName(srcPortNr);
                                elseif sub_atomic.sid == double(dstSid)
                                    dstName = sub_atomic.name;
                                    dstPortName = sub_atomic.getInportName(dstPortNr);
                                end
                            end
                            for coupled_sub_atomic = coupled_sub_atomics
                                coupled_sub_atomic = coupled_sub_atomic{1};
                                if coupled_sub_atomic.sid == double(srcSid)
                                    srcName = coupled_sub_atomic.name;
                                    srcPortName = coupled_sub_atomic.getOutportName(srcPortNr);
                                elseif coupled_sub_atomic.sid == double(dstSid)
                                    dstName = coupled_sub_atomic.name;
                                    dstPortName = coupled_sub_atomic.getInportName(dstPortNr);
                                end
                            end
                            % Zeile schreiben
                            if srcName == atomic_name
                                fprintf(f, '%s.add_coupling(name,"%s","%s","%s");\n', ...
                                    atomic_name, srcPortName, dstName, dstPortName);
                            elseif dstName == atomic_name
                                fprintf(f, '%s.add_coupling("%s","%s",name,"%s");\n', ...
                                    atomic_name, srcName, srcPortName, dstPortName);
                            else
                                fprintf(f, '%s.add_coupling("%s","%s","%s","%s");\n', ...
                                    atomic_name, srcName, srcPortName, dstName, dstPortName);
                            end
                        % 2. Möglichkeit: Ebenfalls keine Branches, aber die Matlab-Struktur
                        % enthält u. U. trotzdem das Feld "Branch", da möglicherweise andere
                        % Line-Elemente einen Branch beinhalten. Nur die if-Abfrage ändert
                        % sich.
                        elseif ismissing(line.Branch)
                            for p = line.P
                                if p.NameAttribute == "Src"
                                    srcSid = split(p.Text, '#');
                                    srcSid = srcSid(1);
                                    srcPortNr = split(p.Text, ':');
                                    srcPortNr = double(srcPortNr(2));
                                elseif p.NameAttribute == "Dst"
                                    dstSid = split(p.Text, '#');
                                    dstSid = dstSid(1);
                                    dstPortNr = split(p.Text, ':');
                                    dstPortNr = double(dstPortNr(2));
                                end
                            end
                            % Namen von Quell- und Zielkomponente bestimmten
                            for sub_atomic = sub_atomics
                                sub_atomic = sub_atomic{1};
                                if sub_atomic.sid == double(srcSid)
                                    srcName = sub_atomic.name;
                                    srcPortName = sub_atomic.getOutportName(srcPortNr);
                                elseif sub_atomic.sid == double(dstSid)
                                    dstName = sub_atomic.name;
                                    dstPortName = sub_atomic.getInportName(dstPortNr);
                                end
                            end
                            for coupled_sub_atomic = coupled_sub_atomics
                                coupled_sub_atomic = coupled_sub_atomic{1};
                                if coupled_sub_atomic.sid == double(srcSid)
                                    srcName = coupled_sub_atomic.name;
                                    srcPortName = coupled_sub_atomic.getOutportName(srcPortNr);
                                elseif coupled_sub_atomic.sid == double(dstSid)
                                    dstName = coupled_sub_atomic.name;
                                    dstPortName = coupled_sub_atomic.getInportName(dstPortNr);
                                end
                            end
                            % Zeile schreiben
                            if srcName == atomic_name
                                fprintf(f, '%s.add_coupling(name,"%s","%s","%s");\n', ...
                                    atomic_name, srcPortName, dstName, dstPortName);
                            elseif dstName == atomic_name
                                fprintf(f, '%s.add_coupling("%s","%s",name,"%s");\n', ...
                                    atomic_name, srcName, srcPortName, dstPortName);
                            else
                                fprintf(f, '%s.add_coupling("%s","%s","%s","%s");\n', ...
                                    atomic_name, srcName, srcPortName, dstName, dstPortName);
                            end
                        % 3. Möglichkeit: Branches existieren
                        else
                            % Es gibt immer nur ein Qeull-Element, aber beliebig verschachtelte
                            % Branches mit verschiedenen Zielen. Daher erst einmal das
                            % Quellkomponente bestimmen, dann alle Branches abarbeiten.
                            for p = line.P
                                if p.NameAttribute == "Src"
                                    srcSid = split(p.Text, '#');
                                    srcSid = srcSid(1);
                                    srcPortNr = split(p.Text, ':');
                                    srcPortNr = double(srcPortNr(2));
                                end
                            end
                            % Branches können beliebig tief verzweigt sein, was sich gut durch
                            % Rekursion abarbeiten lässt. Daher hierzu eine eigene Funktion.
                            printBranches_atomic(f, line, srcSid, srcPortNr, sub_atomics, coupled_sub_atomics, atomic_name);
                        end
                    end


                end
            end
            fprintf(f, "end");
            fclose(f);
            break
        end
        
    end
    sub_atomics = {};           % einfache Atomics in den einzelnen Atomics
    coupled_sub_atomics = {};   % Atomics, die aus weiteren Atomics bestehen
end

end

