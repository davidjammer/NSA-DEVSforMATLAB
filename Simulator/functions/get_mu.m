function x = get_mu()
    global mu
    if ~isempty(mu)
        x = mu;
    else
       x = 0; 
    end
end