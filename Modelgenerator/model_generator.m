function [] = model_generator(model)
    handle = load_system(model);
    name = getfullname(handle);

    mkdir(name);

    names = find_system(name,'SearchDepth',1,'FollowLinks','on','LookUnderMasks','all','Type','Block');
    types = get_param(names, 'BlockType');

    for i=1:length(names)
        read_mdl(names{i});
    end

    create_build_file(name,names);
end