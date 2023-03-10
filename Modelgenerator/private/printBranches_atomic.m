function printBranches_atomic(fileHandle, line, srcSid, srcPortNr, sub_atomics, coupled_sub_atomics, atomic_name)
%printBranches durchläuft alle Branches eines Line-Elements und schreibt
%die Zeile atomic_name.addcoupling(quelle, quellport, ziel, %zielport) für 
%jeden Branch. Ähnelt sehr der printBranches-Funktion, nur dass hier
%anstatt "modelName" bzw. "atomic_name" nur "name" (ohne Anführungszeichen)
%geschrieben wird
%
%   fileHandle: Filedescriptor der zu schreibenden Datei
%
%   line:       Line-Element
%
%   srcSid:     SID des Quellelements der Verbindung
%
%   srcPortNr:  Nummer des Ausgangsports des Quellelements
%
%   sub_atomics: Liste/Vektor der Atomics im gekoppelten Atomic
%
%   coupled_sub_atomics: Liste/Vektor der gekoppelten Atomics im gekoppelten Atomic
%
%   atomic_name: Name des gekoppelten Atomics, für das die Build-Datei
%                erstellt wird

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
                    for k = 1:length(sub_atomics)
                        if sub_atomics{k}.sid == double(srcSid)
                            srcName = sub_atomics{k}.name;
                            srcPortName = sub_atomics{k}.getOutportName(srcPortNr);
                            %disp("Quelle: " + srcName)
                        elseif sub_atomics{k}.sid == double(dstSid)
                            dstName = sub_atomics{k}.name;
                            dstPortName = sub_atomics{k}.getInportName(dstPortNr);
                            %disp("Ziel: " + dstName)
                        end
                    end
                    for k = 1:length(coupled_sub_atomics)
                        if coupled_sub_atomics{k}.sid == double(srcSid)
                            srcName = coupled_sub_atomics{k}.name;
                            srcPortName = coupled_sub_atomics{k}.getOutportName(srcPortNr);
                        elseif coupled_sub_atomics{k}.sid == double(dstSid)
                            dstName = coupled_sub_atomics{k}.name;
                            dstPortName = coupled_sub_atomics{k}.getInportName(dstPortNr);
                        end
                    end
                    % Schreiben der Zeile
                    if srcName == atomic_name
                        fprintf(fileHandle, '%s.add_coupling(name,"%s","%s","%s");\n', ...
                            atomic_name, srcPortName, dstName, dstPortName);
                    elseif dstName == atomic_name
                        fprintf(fileHandle, '%s.add_coupling("%s","%s",name,"%s");\n', ...
                            atomic_name, srcName, srcPortName, dstPortName);
                    else
                        fprintf(fileHandle, '%s.add_coupling("%s","%s","%s","%s");\n', ...
                            atomic_name, srcName, srcPortName, dstName, dstPortName);
                    end
                end
            end
        end
        % Rekursion, falls Branch-Element weitere Branches enthält
        if any(contains(fieldnames(branch), "Branch"))
            printBranches(fileHandle, branch, srcSid, srcPortNr, sub_atomics, coupled_sub_atomics, atomic_name)
        end
    end
end
end
    
