function [] = read_mdl(name)
    
    names = find_system(name,'SearchDepth',1,'FollowLinks','on','LookUnderMasks','all','Type','Block');
    types = get_param(names, 'BlockType');

    if is_atomic(name) == false
        mkdir(name);
        for i=2:length(names)
            read_mdl(names{i});
        end

        create_build_file(name, names(2:end));
    end
end