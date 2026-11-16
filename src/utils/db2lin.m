function x = db2lin(x_dB)
%DB2LIN Power ratio from dB: 10^(x_dB/10).
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

x = 10.^(x_dB/10);
end
