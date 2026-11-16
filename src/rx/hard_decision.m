function bits = hard_decision(y)
%HARD_DECISION BPSK hard decision: y >= 0 -> bit 0, y < 0 -> bit 1.
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

bits = double(y < 0);
end
