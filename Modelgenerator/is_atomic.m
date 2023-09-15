function out = is_atomic(name)
    names = find_system(name,'SearchDepth',1,'FollowLinks','on','LookUnderMasks','all','Type','Block');
    types = get_param(names, 'BlockType');

    for i=2:length(types)
        if types(i) == "SubSystem"
            out = false;
            return;
        end
    end
    out = true;
end