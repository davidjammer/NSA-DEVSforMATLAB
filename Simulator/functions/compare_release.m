function [out] = compare_release(release)

v = ver('MATLAB');
year1 = v.Release(3:end-2);
x1 = v.Release(end-1);

r = char(release);
year2 = r(2:end-1);
x2 = r(end);

y1 = str2num(year1)*10 + (x1=='b');
y2 = str2num(year2)*10 + (x2=='b');

out = y2 <= y1;

end

