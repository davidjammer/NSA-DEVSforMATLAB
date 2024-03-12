function [out] = ieee1164_and(in1,in2)

table={'U', 'U', '0', 'U', 'U', 'U', '0', 'U', 'U';
       'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X';
       '0', '0', '0', '0', '0', '0', '0', '0', '0';
       'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X';
       'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X';
       'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X';
       '0', '0', '0', '0', '0', '0', '0', '0', '0';
       'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X';
       'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X'};
index = {'U' 'X' '0' '1' 'Z' 'W' 'L' 'H' '-'};

row = find(index==in1);
col = find(index==in2);

out = convertCharsToStrings(table{row,col});
end

