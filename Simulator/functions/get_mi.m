function x = get_mi()
    global mi
    if ~isempty(mi)
        x = mi;
    else
       x = 0; 
    end
end