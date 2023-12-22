function [check] = check_tn(tn,t)
    ts = tn - t;
    if ts(1) > 0
        check = true;
    elseif ts(1) == 0 && ts(2) > 0
        check = true;
    else
        check = false;
    end
end

