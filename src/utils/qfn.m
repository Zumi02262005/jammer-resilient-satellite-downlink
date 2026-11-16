function q = qfn(x)
%QFN Gaussian Q-function, Q(x) = 0.5*erfc(x/sqrt(2)) (no toolbox needed).
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

q = 0.5 * erfc(x / sqrt(2));
end
