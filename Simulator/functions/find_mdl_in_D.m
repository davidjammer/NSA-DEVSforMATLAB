function idx = find_mdl_in_D(D, name)
    idx=[];
    for i=1:length(D)
        if(~isempty(D{i}))
            if(strcmp(name,D{i}.get_name))
                idx=i;
                break;
            end
        end
    end
end