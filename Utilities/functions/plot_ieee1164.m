function plot_ieee1164(t,y)
    cats = ["U", "X", "0", "1", "Z", "W", "L", "H", "-"];
    ph = categorical(y, cats, "Ordinal", true);
    stairs(t, ph,'-*');
end

