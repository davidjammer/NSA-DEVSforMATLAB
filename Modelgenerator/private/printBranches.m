function printBranches(fileHandle, line, srcSid, srcPortNr, atomics, coupled_models, modelName)
%printBranches durchläuft alle Branches eines Line-Elements und schreibt
%die Zeile MODELNAME.addcoupling(quelle, quellport, ziel, zielport) für 
%jeden Branch.
%
%   fileHandle: Filedescriptor der zu schreibenden Datei
%
%   line:       Line-Element
%
%   srcSid:     SID des Quellelements der Verbindung
%
%   srcPortNr:  Nummer des Ausgangsports des Quellelements
%
%   atomics:    Liste/Vektor einfacher Atomics des Modells
%
%   coupled_models: Liste der gekoppelten Atomics
%
%   modelName:  Name des Modells


if any(contains(fieldnames(line), "Branch"))
    % gehe durch alle Branch-Tags
    for branch = line.Branch
        % gehe durch P-Tags des Branch
        if any(contains(fieldnames(branch), "P"))
            for p = branch.P
                % Ziel (SID) der Verbindung bestimmten
                if p.NameAttribute == "Dst"
                    dstSid = split(p.Text, '#');
                    dstSid = dstSid(1);
                    dstPortNr = split(p.Text, ':');
                    dstPortNr = double(dstPortNr(2));
                    % Objekte der durch Linie verbundenen Komponenten finden
                    for k = 1:length(atomics)
                        if atomics{k}.sid == double(srcSid)
                            srcName = atomics{k}.name;
                            srcPortName = atomics{k}.getOutportName(srcPortNr);
                        elseif atomics{k}.sid == double(dstSid)
                            dstName = atomics{k}.name;
                            dstPortName = atomics{k}.getInportName(dstPortNr);
                        end
                    end
                    for k = 1:length(coupled_models)
                        if coupled_models{k}.sid == double(srcSid)
                            srcName = coupled_models{k}.name;
                            srcPortName = coupled_models{k}.getOutportName(srcPortNr);
                        elseif coupled_models{k}.sid == double(dstSid)
                            dstName = coupled_models{k}.name;
                            dstPortName = coupled_models{k}.getInportName(dstPortNr);
                        end
                    end
                    % Schreiben der Zeile
                    fprintf(fileHandle, '%s.add_coupling("%s","%s","%s","%s");\n', ...
                        modelName, srcName, srcPortName, dstName, dstPortName);
                end
            end
        end
        % Rekursion, falls Branch-Element weitere Branches enthält
        if any(contains(fieldnames(branch), "Branch"))
            printBranches(fileHandle, branch, srcSid, srcPortNr, atomics, coupled_models, modelName)
        end
    end
end
end
    
