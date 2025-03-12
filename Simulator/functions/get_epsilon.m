function x = get_epsilon()
    global epsilon
    if ~isempty(epsilon)
        x = epsilon;
    else
       x = 1e-10; 
    end
end