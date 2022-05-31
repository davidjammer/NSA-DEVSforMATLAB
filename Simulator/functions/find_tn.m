function id=find_tn(eventlist,tn)

    x=find(eventlist(:,2) == tn(1));

    id=[];

    for i=1:numel(x)
        if eventlist(x(i),3) == tn(2)
            id=[id;x(i)]; 
        end
    end

end

