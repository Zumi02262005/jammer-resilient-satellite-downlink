function d = design_info(p, design)
%DESIGN_INFO Switches and derived numbers for one design.
%
%   design 1 - plain BPSK
%   design 2 - DSSS-BPSK (31-chip PN)
%   design 3 - DSSS-BPSK + Hamming(7,4) + block interleaver
%   design 4 - design 3 without the interleaver (interleaver comparison)
%
%   d.spread, d.coded, d.interleaved - logical switches
%   d.Ns     - samples (chips) per transmitted symbol
%   d.rate   - code rate (1 if uncoded)
%   d.GpEff  - spread bandwidth over information bit rate, Ns/rate (linear)
%   d.name   - label for plots
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

names = {'Design 1: plain BPSK', 'Design 2: DSSS-BPSK', ...
    'Design 3: DSSS + Hamming(7,4) + interleaver', ...
    'Design 3 without interleaver'};
d.spread      = design >= 2;
d.coded       = design >= 3;
d.interleaved = design == 3;
d.Ns          = 1;  if d.spread, d.Ns = p.N; end
d.rate        = 1;  if d.coded,  d.rate = p.rate; end
d.GpEff       = d.Ns / d.rate;
d.name        = names{design};
end
