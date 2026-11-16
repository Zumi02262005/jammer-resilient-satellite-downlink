function pn = pn_mseq(nStages, taps, seed)
%PN_MSEQ Maximal-length PN sequence (+1/-1) from a Fibonacci LFSR.
%
%   nStages - LFSR length (5 gives 31 chips)
%   taps    - feedback tap positions, e.g. [5 2]
%   seed    - nonzero initial register state (1 x nStages of 0/1)
%   pn      - (2^nStages - 1) x 1 column of +1/-1 chips (0 -> +1, 1 -> -1)
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

if ~any(seed)
    error('pn_mseq:zeroSeed', 'The LFSR seed must not be all zeros.');
end
L   = 2^nStages - 1;
reg = seed(:).';
seq = zeros(L, 1);
for k = 1:L
    seq(k) = reg(end);                   % output the last stage
    fb     = mod(sum(reg(taps)), 2);     % XOR of the tapped stages
    reg    = [fb, reg(1:end-1)];         % shift
end
pn = 1 - 2*seq;
end
