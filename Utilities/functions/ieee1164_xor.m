function [out] = ieee1164_xor(in1,in2)

table={'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U';
       'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X';
       'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X';
       'U', 'X', '1', '0', 'X', 'X', '1', '0', 'X';
       'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X';
       'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X';
       'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X';
       'U', 'X', '1', '0', 'X', 'X', '1', '0', 'X';
       'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'};
index = {'U' 'X' '0' '1' 'Z' 'W' 'L' 'H' '-'};

row = find([index{:}]==in1);
col = find([index{:}]==in2);

out = convertCharsToStrings(table{row,col});
end

