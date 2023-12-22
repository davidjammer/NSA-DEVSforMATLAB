function [out] = ieee1164_or(in1,in2)

table={'U', 'U', 'U', '1', 'U', 'U', 'U', '1', 'U';
       'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X';
       'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X';
       '1', '1', '1', '1', '1', '1', '1', '1', '1';
       'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X';
       'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X';
       'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X';
       '1', '1', '1', '1', '1', '1', '1', '1', '1';
       'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X'};
index = {'U' 'X' '0' '1' 'Z' 'W' 'L' 'H' '-'};

row = find(index==in1);
col = find(index==in2);

out = convertCharsToStrings(table{row,col});
end

