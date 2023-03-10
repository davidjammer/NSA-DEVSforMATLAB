function [atomics, coupled_atomics, to_build] = generate_atomics(libraryFile, outPath, libName)
%Erzeugt für jedes Atomic in der %Bibliotheksdatei eine eine Klassendatei
%für dieses.
%
%   libraryFile:    .slx-Datei, welche die atomaren Komponenten enthält.
%                   Jedes Atomic benötigt in der Maske einen Parameter vom
%                   Typ Edit mit dem Namen "constructor". In diesen die
%                   Syntax des Konstruktoraufrufs in einfachen Anführungszeichen
%                   einzutragen. String-Parameter sind mit doppelten
%                   Anführungszeichen zu umschließen.
%                   Beispiel: 'generator("name", ts, tau)'
%                   Die Namen der Parameter im Konstruktor müssen denen der
%                   anderen Parameter entsprechen!
%   
%   outPath:        Verzeichnis, in welchem ein Ordner atomics mit den
%                   Klassendateien erstellt wird. Weiterhin wird hier auch
%                   die Bibliotheksdatei (.slx) in ein gleichnamiges
%                   Verzeichnis entpackt, das nach Abarbeitung wieder
%                   gelöscht wird.
%
%   libName:        Name der Bibliotheksdatei. Nur innerhalb rekursiver
%                   Aufrufe gesetzt

%% Bibliotheksdatei entpacken
if nargin < 3
    [~, libName, ~] = fileparts(libraryFile);
end

% aktuelles Verzeichnis merken, um später wieder zurückzuwechseln
currentPath = pwd;

% Verzeichnisse erstellen, XML in Struktur einlesen
if endsWith(libraryFile, ".slx")
    if ~exist(outPath + "/atomics", "dir")
        mkdir(outPath + "/atomics");
    end
    unzip(libraryFile, outPath + "/" + libName);
    cd(outPath);
    xml = readstruct(libName + "/simulink/systems/system_root.xml");
    [~, libName, ~] = fileparts(libraryFile);
else
    xml = readstruct(libName + "/simulink/systems/" + libraryFile);
end

libraryPath = libName + "/simulink/systems/";

%% Klassendateien erzeugen
atomics = string([]);           % Namen einfacher Atomics
coupled_atomics = string([]);   % Namen gekoppelter Atomics
coupled_atomics_sids = [];      % SIDs gekoppelter Atomics
build_coupled_functions = {};
% Jedes Block-Element stellt atomic-Komponente dar.
% Erstelle für jede Komponente eine Klasse.
for block = xml.Block
    
    % Für jedes Atomic existiert auch eine eigene XML-Datei, daher sind die
    % Blöcke vom Typ "Subsystem". Sollte, warum auch immer, doch mal ein
    % anderer Blocktyp dazwischen sein, überspringe ihn einfach
    if block.BlockTypeAttribute ~= "SubSystem"
        continue
    end

    block_xml = readstruct(libName + "/simulink/systems/system_" + block.SIDAttribute + ".xml");

    % Bearbeite Sublibraries die über OpenFcn verlinkt wurden. Also
    % Libraries, die entsprechend folgender Anleitung im Library-Browser
    % als Unterbibliothek angezeigt werden
    % https://de.mathworks.com/help/simulink/ug/adding-libraries-to-the-library-browser.html
    isSubLib = false;
    for p = block.P
        if p.NameAttribute == "OpenFcn"
            subLibName = p.Text + ".slx";
            isSubLib = true;
        end
    end
    % Wenn es eine ensprechende Bibliothek ist, dann erstelle auch für
    % diese die Atomics-Klassen (und Funktionen der gekoppelten Atomics)
    if isSubLib
        [newAtomics, newcoupled_atomics, build_coupled_functions{end+1}] = generate_atomics(subLibName, ".");
        atomics = [atomics, newAtomics];
        coupled_atomics = [coupled_atomics, newcoupled_atomics];
        continue
    end

    % Sublibraries können auch in einem Subsystem-Block ohne Ein- und
    % Ausgänge hizugefügt werden
    for portcount=block.PortCounts
        if class(portcount) == "string" && portcount == ""
            fileName = block.System.RefAttribute;
            isSubLib = true;
        end
    end
    % In diesem Fall erstelle auch hierfür die Atomic-Klassen
    if isSubLib
        [newAtomics, newcoupled_atomics, build_coupled_functions{end+1}] = generate_atomics(fileName + ".xml", ".", libName);
        atomics = [atomics, newAtomics];
        coupled_atomics = [coupled_atomics, newcoupled_atomics];
        continue
    end

    % Handelt es sich um ein Atomic oder um ein Coupled-Atomic? Lies dazu
    % die XML-Datei der Komponente ein. Sind die einzigen Blöcke
    % In-/Outports, dann ist es ein Atomic. Coupled-Atomics beinhalten
    % Blöcke vom Typ "Reference"
    isCoupledModel = false;
    for blck = block_xml.Block
        if blck.BlockTypeAttribute == "Reference"
            isCoupledModel = true;
            break
        end
    end
    if isCoupledModel
        coupled_atomics(end+1) = block.NameAttribute;
        coupled_atomics_sids(end+1) = block.SIDAttribute;
    else
        atomics(end+1) = block.NameAttribute;
    end

    % Liste über Properties führen, um darüber iterieren zu können
    properties = string([]);

    % Atomic-Name = Name der Komponente in Simulink
    atomic_name = block.NameAttribute;
    classFile = fopen("./atomics/" + string(atomic_name) + "_" + libName + ".m", "w");
    fprintf(classFile, "classdef %s_%s\n", atomic_name, libName);

    % Properties
    fprintf(classFile, "\n\tproperties\n");
    % SID und einen Namen haben alle Komponenten
    fprintf(classFile, "\t\tsid\n");
    fprintf(classFile, "\t\tname\n");
    fprintf(classFile, "\t\tlibName = '%s'\n", libName);
    for parameter = block.Mask.MaskParameter
        % Die Constructor-Eigenschaft auslassen
        if parameter.NameAttribute == "constructor"
            continue
        end
        fprintf(classFile, "\t\t%s\n", parameter.NameAttribute);
        % Name der in Property-Liste aufnehmen
        properties(end+1) = parameter.NameAttribute;
    end
    fprintf(classFile, "\tend\n\n");
    % Ende Properties


    % Methoden
    fprintf(classFile, "\tmethods\n");
    
    % Konstruktor
    fprintf(classFile, "\t\tfunction obj = %s_%s(xmlBlock)\n", atomic_name, libName);
    % SID und Name
    fprintf(classFile, "\t\t\tobj.sid = xmlBlock.SIDAttribute;\n");
    fprintf(classFile, "\t\t\tobj.name = xmlBlock.NameAttribute;\n");
    fprintf(classFile, "\t\t\tinstanceData = xmlBlock.InstanceData;\n");
    fprintf(classFile, "\t\t\tfor k = 1:length(instanceData.P)\n");
    % jeder Property den entsprechenden Wert zuweisen
    for k = 1:length(properties)
        if k == 1
            fprintf(classFile, '\t\t\t\tif instanceData.P(k).NameAttribute == "%s"\n', properties(k));
            fprintf(classFile, '\t\t\t\t\tobj.%s = instanceData.P(k).Text;\n', properties(k));
        else
            fprintf(classFile, '\t\t\t\telseif instanceData.P(k).NameAttribute == "%s"\n', properties(k));
            fprintf(classFile, '\t\t\t\t\tobj.%s = instanceData.P(k).Text;\n', properties(k));
        end
    end
    fprintf(classFile, "\t\t\t\tend\n");
    fprintf(classFile, "\t\t\tend\n");
    fprintf(classFile, "\t\tend\n");
    % Ende Konstruktor

    % getContructor-Funktion
    % Gibt den in Simulink eingetragenen Konstruktor zurück
    % So ist es am einfachsten herauszufinden, welche Parameter in
    % Anführungszeichen übergeben werden
    fprintf(classFile, "\n\t\tfunction [text] = getConstructor(obj)\n");
    for parameter = block.Mask.MaskParameter
        if parameter.NameAttribute == "constructor"
            % Name der Konstruktor Funktion und Parameter holen
            constructorStr = parameter.Value;
            constructorStr = erase(constructorStr, "'");
            constructorName = constructorStr.split("(");
            constructorParams = constructorName(2);
            constructorName = constructorName(1);
            constructorParams = strsplit(constructorParams, ")");
            constructorParams = constructorParams(1:end-1);
            constructorParams = strsplit(constructorParams, ",");
            constructorParams = strtrim(constructorParams);
            
            % Schreiben der Funktion
            fprintf(classFile, "\t\t\ttext = sprintf('%s(", constructorName);
            for k = 1:length(constructorParams)
                if k == length(constructorParams)
                    if startsWith(constructorParams(k), '"')
                        fprintf(classFile, '"%%s")'',');
                    else
                        fprintf(classFile, '%%s)'',');
                    end
                else
                    if startsWith(constructorParams(k), '"')
                        fprintf(classFile, '"%%s",');
                    else
                        fprintf(classFile, '%%s,');
                    end
                end
            end

            for k = 1:length(constructorParams)
                if k == length(constructorParams)
                    fprintf(classFile, " string(obj.%s));\n", erase(constructorParams(k), '"'));
                else
                    fprintf(classFile, " string(obj.%s),", erase(constructorParams(k), '"'));
                end
            end
        end
    end
    fprintf(classFile, "\t\tend\n\n");

    % getInportName
    % Zwar verfügen nicht alle Atomics über mehrere Ein- und Ausgänge,
    % für einen einheitlichen Aufruf der Funktion wird trotzdem immer
    % die Syntax get...Port(obj, nr) verwendet
    fprintf(classFile, "\n\t\tfunction [text] = getInportName(~, nr)\n");
    displayTextField = strsplit(block.Mask.Display.Text, "port_label");
    ports = string([]);
    for tf = displayTextField
        if contains(tf, "input")
            ports(end+1) = tf;
        end
    end
    if isempty(ports)
        fprintf(classFile, '\t\t\ttext = "";\n');
    else
        fprintf(classFile, '\t\t\tswitch nr\n');
        for k = 1:length(ports)
            port = strsplit(ports(k), ",");
            port = strtrim(erase(port, ["(",")","'",";"]));
            fprintf(classFile, '\t\t\t\tcase %d\n', k);
            fprintf(classFile, '\t\t\t\t\ttext = "%s";\n', port(3));
        end
        fprintf(classFile, "\t\t\tend\n");
    end
    fprintf(classFile, "\t\tend\n");

    % getOutportName
    fprintf(classFile, "\n\t\tfunction [text] = getOutportName(~, nr)\n");
    displayTextField = strsplit(block.Mask.Display.Text, "port_label");
    ports = string([]);
    for tf = displayTextField
        if contains(tf, "output")
            ports(end+1) = tf;
        end
    end
    if isempty(ports)
        fprintf(classFile, '\t\t\ttext = "";\n');
    else
        fprintf(classFile, '\t\t\tswitch nr\n');
        for k = 1:length(ports)
            port = strsplit(ports(k), ",");
            port = strtrim(erase(port, ["(",")","'",";"]));
            fprintf(classFile, '\t\t\t\tcase %d\n', k);
            fprintf(classFile, '\t\t\t\t\ttext = "%s";\n', port(3));
        end
        fprintf(classFile, "\t\t\tend\n");
    end
    fprintf(classFile, "\t\tend\n");
    % Ende getOutportName

    fprintf(classFile, "\tend\n");
    % Ende Methoden

    fprintf(classFile, "end\n");
    fclose(classFile);
end


% Da Subsysteme in einem System auch Ein- und Ausgänge mit variierenden
% Namen besitzen können, wird auch hierfür eine Klasse benötigt. Diese
% sollte jedoch immer gleich aussehen und kann direkt codiert werden. 

% subsystem-Klasse
classFile = fopen("./atomics/" + "subsystem1.m", "w");
fprintf(classFile, ...
"classdef subsystem1\n" + ...
    "\tproperties\n" + ...
	    "\t\tsid\n" + ...
	    "\t\tname\n" + ...
        "\t\tinPorts = string([])\n" + ...
        "\t\toutPorts = string([])\n" + ...
        "\t\tparameter = {}\n" + ...
    "\tend\n" + ...
    "\tmethods\n" + ...
        "\t\tfunction obj = subsystem1(xml, path, modelName)\n" + ...
		    "\t\t\tobj.sid = xml.SIDAttribute;\n" + ...
		    "\t\t\tobj.name = modelName + ""_"" + xml.NameAttribute;\n" + ...
            "\t\t\t%% subsystem Datei einlesen, um Portnamen zu bekommen\n" + ...
            "\t\t\tsubXml = readstruct(path + ""/"" + xml.System.RefAttribute + "".xml"");\n" + ...
            "\t\t\tfor k = 1:length(subXml.Block)\n" + ...
                "\t\t\t\tif subXml.Block(k).BlockTypeAttribute == ""Inport""\n" + ...
                    "\t\t\t\t\tobj.inPorts(end+1) = subXml.Block(k).NameAttribute;\n" + ...
                "\t\t\t\telseif subXml.Block(k).BlockTypeAttribute == ""Outport""\n" + ...
                    "\t\t\t\t\tobj.outPorts(end+1) = subXml.Block(k).NameAttribute;\n" + ...
                "\t\t\t\tend\n" + ...
            "\t\t\tend\n" + ...
            "\t\t\tif any(contains(fieldnames(xml), 'Mask'))\n" + ...
            "\t\t\t\tfor parameter = xml.Mask.MaskParameter\n" + ...
                    "\t\t\t\t\tobj.parameter{end+1} = struct(parameter.NameAttribute, parameter.Value);\n" + ...
                "\t\t\t\tend\n" + ...
            "\t\t\tend\n" + ...
        "\t\tend\n" + ...
        "\t\tfunction [text] = getInportName(obj, nr)\n" + ...
            "\t\t\ttext = obj.inPorts(nr);\n" + ...
        "\t\tend\n" + ...
        "\t\tfunction [text] = getOutportName(obj, nr)\n" + ...
            "\t\t\ttext = obj.outPorts(nr);\n" + ...
        "\t\tend\n" + ...
    "\tend\n" + ...
"end\n");
fclose(classFile);

% Innerhalb eines Subsystems gibt es wiederum Ein- und Ausgänge zum
% übergeordnenen System. Auch hier wieder mit unterschiedlichem Namen,
% aber immer dem selben Schema folgend. Daher auch hierfür eine
% hartcodierte Klassendatei.

% inoutPort-Klasse
classFile = fopen("./atomics/" + "inoutPort.m", "w");
fprintf(classFile, ...
"classdef inoutPort\n"  + ...
    "\tproperties\n" + ...
	    "\t\tsid\n" + ...
	    "\t\tname\n" + ...
        "\t\tportName\n" + ...
    "\tend\n" + ...
    "\tmethods\n" + ...
        "\t\tfunction obj = inoutPort(sid, modelName, portName)\n" + ...
	        "\t\t\tobj.sid = sid;\n" + ...
		    "\t\t\tobj.name = modelName;\n" + ...
            "\t\t\tobj.portName = portName;\n"  + ...
        "\t\tend\n"   + ...
        "\t\tfunction [text] = getInportName(obj, nr)\n" + ...
            "\t\t\ttext = obj.portName;\n" + ...
        "\t\tend\n"   + ...
        "\t\tfunction [text] = getOutportName(obj, nr)\n" + ...
            "\t\t\ttext = obj.portName;\n" + ...
        "\t\tend\n"   + ...
    "\tend\n" + ...
"end\n");
fclose(classFile);
    

addpath("./atomics");
%% Die Atomic-Klassendateien sind erstellt
% Es müssen aber noch die Build-Dateien für die zusammengesetzten Atomics
% aus der Bibliothek erzeugt werden
% rufe das erst nach dem Generieren aller Atomics auf
build_coupled_functions = [build_coupled_functions, ...
struct( 'libraryPath', libraryPath, ...
        'xml', xml, ...
        'coupled_atomics_sids', coupled_atomics_sids, ...
        'coupled_atomics', coupled_atomics, ...
        'libName', libName)];
to_build = build_coupled_functions;
    
%% Aufräumen
if endsWith(libraryFile, ".slx")
    % Das Verzeichnis mit der entpackten Bibliotheksdatei entfernen und die
    % Atomic-Klassendateien zum Ausführungspfad hinzufügen
    %rmdir(libName, "s");
    
    % Wechel ins Ausgangsverzeichnis
    cd(currentPath);
end

end