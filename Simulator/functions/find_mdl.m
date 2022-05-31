function idx = find_mdl(receivers, name)
    idx=[];
    for i=1:length(receivers)
        if(strcmp(name,receivers(i).name))
            idx=i;
            break;
        end
    end
end
