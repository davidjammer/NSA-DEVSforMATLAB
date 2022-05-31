function s = struct2string(x)
% returns a string containing the values of the fields
% small version, without field names

t1 = structfun(@faux, x);
s = "";
for I=1:length(t1)
  s = s + t1(I);
end
s = extractBefore(s, strlength(s));


function y = faux(x)
% transform to string, empty field values to "[]", add trailing "/"
if isempty(x) 
  y = "[]";
else
  y = string(x);
end
y = y + "/";
