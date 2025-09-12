function id=find_tn(eventlist,tn)
    %x=find(eventlist(:,2) == tn(1));   
    x=find(abs(eventlist(:,2)-tn(1)) < get_epsilon() == 1);
    id=[];
    for i=1:numel(x)
        if abs(eventlist(x(i),3) - tn(2)) < get_epsilon()
            id=[id;x(i)]; 
        end
    end
end