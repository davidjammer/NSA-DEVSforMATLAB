function x = get_defdelay()
    global taudef
    if ~isempty(taudef)
        x = taudef;
    else
       x = 1; 
    end
end