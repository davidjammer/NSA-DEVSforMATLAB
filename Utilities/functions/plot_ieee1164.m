function plot_ieee1164(t,y,cats)
    if nargin == 2
      cats = ["U", "X", "0", "1", "Z", "W", "L", "H", "-"];
    end
    ph = categorical(y, cats, "Ordinal", true);
    stairs(t, ph,'-*');
end

