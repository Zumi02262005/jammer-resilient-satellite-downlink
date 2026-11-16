function sym = bpsk_map(bits)
%BPSK_MAP BPSK mapping: bit 0 -> +1, bit 1 -> -1.
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

sym = 1 - 2*bits;
end
