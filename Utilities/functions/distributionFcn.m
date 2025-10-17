function value = distributionFcn(name, para)
% generates random numbers from a distribution based on a global stream
% Inputs:
%   name   name of distribution as string
%   para   numeric vector with parameters of distribution
% Outputs:
%   value  random number from the distribution

% 2025/09/27 TP
  
  if name ~= "Constant"
    randNumber = rand();        % use global stream
  end

  switch name 
    case "Constant"
      value = para;
    case "Exponential" 
       mu = para;
       value = -mu * log(randNumber);
    case "Triangular"
       a = para(1); m = para(2); b = para(3); % min most max value
       u = randNumber;
       mp = (m - a)/(b - a);
       if u <= mp
           x = sqrt(mp*u);
       else
           x = 1 - sqrt((1 - mp)*(1 - u));
       end
       value = a + (b - a)*x;
    otherwise
       error("Name of distribution is unknown.")
  end
end
