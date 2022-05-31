function x = get_debug_level()
    global DEBUGLEVEL
    if ~isempty(DEBUGLEVEL)
        x = DEBUGLEVEL;
    else
       x = 0; 
    end
end