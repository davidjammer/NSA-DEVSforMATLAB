function [out] = ieee1164_not(in)

table={ 'U', 'X', '1', '0', 'X', 'X', '1', '0', 'X'};

index = {'U' 'X' '0' '1' 'Z' 'W' 'L' 'H' '-'};

col = find(index==in);

out = convertCharsToStrings(table{col});
end

