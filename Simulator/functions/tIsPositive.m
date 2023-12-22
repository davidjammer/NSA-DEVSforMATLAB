function flag = tIsPositive(t)
  % flag is true <=> hyperreal t is >= 0
  flag = (t(1) > 0) || (t(1) == 0 && t(2) >= 0);
end
