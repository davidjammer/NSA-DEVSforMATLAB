function [M, I] = minHR(t)
% returns the minimal value of a vector of hyperreals and its index
% Parameters:
%   t    Nx2-array denoting N hyperreals a + b E
% Outputs:
%   M    smallest hyperreal in t
%   I    index of M in t

z = t(:,1) + t(:,2)*1i;
[~, I] = min(z, [], "ComparisonMethod", "real");
M = t(I,:);
