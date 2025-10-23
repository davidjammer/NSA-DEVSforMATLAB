function [] = create_build_file(name,names) 
    types = get_param(names, 'BlockType');

    fid = fopen(name+"/build_" + get_param(name,'Name') + ".m", 'w');
    fprintf(fid,"function " +get_param(name,'Name')+ " = build_"+get_param(name,'Name')+"(name");
    if(get_param(name, 'Type') == "block")
    	if(get_param(name,'Mask') == "on")
      	params = get_param(name,'DialogParameters');
      	if isstruct(params)
        	parameters = fieldnames(params);
        	for k=1:length(parameters)
          	fprintf(fid,",%s",parameters{k});
        	end
      	end
    	end
	end
    fprintf(fid,")\n");
    

    fprintf(fid,"%s = coordinator(name);\n", get_param(name,'Name'));

    fprintf(fid,"\n%%create atomics\n");
    for i=1:length(names)
        if is_atomic(names(i)) == true && types(i) == "SubSystem"
            fprintf(fid, "atomic_%s = %s(""%s""", get_param(names{i},'Name'),get_param(get_param(names{i},'ReferenceBlock'),'Name'),get_param(names{i},'Name'));
            if(isfield(get_param(names{i},'ObjectParameters'),'DialogParameters'))
                parameters = fieldnames(get_param(names{i},'DialogParameters'));
                for k=1:length(parameters)
                    fprintf(fid,",%s",get_param(names{i},parameters{k}));
                end
            end
            fprintf(fid,");\n");
        end
    end
    
    fprintf(fid,"\n%%add atomics to simulators\n");
    for i=1:length(names)
        if is_atomic(names(i)) == true && types(i) == "SubSystem"
            fprintf(fid, "devs_%s = devs(atomic_%s);\n", get_param(names{i},'Name'), get_param(names{i},'Name'));
        end
    end

    fprintf(fid,"\n%%create coupled models\n");
    for i=1:length(names)
        if is_atomic(names(i)) == false && types(i) == "SubSystem"
            fprintf(fid, "addpath(""%s/%s"");\n",pwd,names{i});
            fprintf(fid, "%s = build_%s(""%s""", get_param(names{i},'Name'),get_param(names{i},'Name'),get_param(names{i},'Name'));
            if(get_param(names{i},'Mask') == "on")
                params = get_param(names{i},'DialogParameters');
                if isstruct(params)
                  parameters = fieldnames(params);
                  for k=1:length(parameters)
                    fprintf(fid,",%s",get_param(names{i},parameters{k}));
                  end
                end
            end
            fprintf(fid,");\n");
            
            fprintf(fid, "rmpath(""%s/%s"");\n",pwd,names{i});
        end
    end

    fprintf(fid,"\n%%add simulators and models to coordinator\n");
    for i=1:length(names)
        if types(i) == "SubSystem"
            if is_atomic(names(i))
                fprintf(fid, "%s.add_model(devs_%s);\n", get_param(name,'Name'), get_param(names{i},'Name'));
            else
                fprintf(fid, "%s.add_model(%s);\n", get_param(name,'Name'), get_param(names{i},'Name'));
            end
        end
    end

    fprintf(fid,"\n%%add couplings\n");

    lines = find_system(name,'FindAll','on','SearchDepth',1,'FollowLinks','on','LookUnderMasks','all','type','line');

    for i=1:length(lines)
        

        [from_model,from_port,to_model,to_port] = get_coupling(get_param(name,'Name'), lines(i));
        if length(from_model) == 1
            for j=1:length(from_model)
                if strcmp(from_model{j}, get_param(name,'Name'))
                    fprintf(fid, "%s.add_coupling(name,""%s"",""%s"",""%s"");\n",get_param(name,'Name'),from_port{j},to_model{j},to_port{j});
                elseif strcmp(to_model{j}, get_param(name,'Name'))
                    fprintf(fid, "%s.add_coupling(""%s"",""%s"",name,""%s"");\n",get_param(name,'Name'),from_model{j},from_port{j},to_port{j});
                else
                    fprintf(fid, "%s.add_coupling(""%s"",""%s"",""%s"",""%s"");\n",get_param(name,'Name'),from_model{j},from_port{j},to_model{j},to_port{j});
                end
            end
        end
    end

    fprintf(fid,"end\n");
    fclose(fid);

end