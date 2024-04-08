function out = testMinHR(nr)
if nargin == 0
  nr = 1;
end

switch nr
  case 1
    t = [6, 3; 8, 8; 1, 4; 2, 7; 4, 5]; % -> M = [1, 4]; I = 3;
  case 2
    t = [6, 3; 1, 2; 2, 4; 1, 1; 4, 5]; % -> M = [1, 1]; I = 4;
  case 3
    t = [6, 3; 1, 1; 2, 4; 1, 1; 4, 5]; % -> M = [1, 1]; I = 2;
  otherwise
    t = [6, 3; 8, 8; 1, 4; 2, 7; 4, 5]; % -> M = [1, 4]; I = 3;
end

[M, I] = minHR(t);
out.M = M;
out.I = I;
