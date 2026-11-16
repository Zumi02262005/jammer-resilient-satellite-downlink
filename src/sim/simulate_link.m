function [nErr, nBits] = simulate_link(p, design, jam, JS_dB)
%SIMULATE_LINK Send one batch of bits through one design; count bit errors.
%
%   Chain: bits -> [Hamming(7,4)] -> [interleaver] -> BPSK -> [PN spreading]
%          -> channel (AWGN + jammer) ->
%          [despreading] -> hard decision -> [deinterleaver] -> [decoder]
%   Blocks in brackets are switched on or off by the design number.
%
%   All designs use the same energy per information bit. Chips have
%   amplitude 1, so Eb = Ns/rate and the noise is scaled from Es/N0 =
%   rate * Eb/N0.
%
%   p      - parameter struct from params(); uses p.EbN0_dB as the Eb/N0
%   design - 1 plain BPSK, 2 DSSS, 3 DSSS + Hamming + interleaver,
%            4 design 3 without the interleaver
%   jam    - jammer struct:
%              jam.type       'none' | 'tone' | 'pulsed'
%              jam.fOffsetSym tone offset in multiples of the symbol rate
%              jam.rho        pulsed duty cycle, or 'worst' for
%                             rho = min(1, 1/(Es/J0))
%   JS_dB  - jammer-to-signal ratio in dB (ignored when jam.type = 'none')
%   nErr   - information-bit errors in this batch
%   nBits  - information bits in this batch
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

d = design_info(p, design);

% ---- Transmitter ----
bits = gen_info_bits(p.batchBits);
tx = bits;
if d.coded
    tx = hamming74_encode(tx);
    if d.interleaved
        tx = block_interleave(tx, p.ilvRows, p.ilvCols);
    end
end
x = bpsk_map(tx);
if d.spread
    pn = pn_mseq(p.pnStages, p.pnTaps, p.pnSeed);
    x  = dsss_spread(x, pn);
end
nSamp = numel(x);

% ---- Channel: AWGN + jammer ----
EsN0_dB = p.EbN0_dB + 10*log10(d.rate);
r = add_awgn(x, EsN0_dB, d.Ns);

switch jam.type
    case 'none'
        % AWGN only
    case 'tone'
        fNorm = jam.fOffsetSym / d.Ns;           % cycles per chip
        r = r + jammer_tone(nSamp, JS_dB, fNorm, 2*pi*rand);
    case 'pulsed'
        rho = jam.rho;
        if ischar(rho)                           % 'worst'
            EsJ0 = d.Ns / 10^(JS_dB/10);
            rho  = min(1, 1/EsJ0);
        end
        r = r + jammer_pulsed(nSamp, JS_dB, rho, p.pulseLenSyms * d.Ns);
    otherwise
        error('simulate_link:jamType', 'Unknown jammer type "%s".', jam.type);
end

% ---- Receiver ----
if d.spread
    y = dsss_despread(r, pn);
else
    y = r;
end
rx = hard_decision(y);
if d.coded
    if d.interleaved
        rx = block_deinterleave(rx, p.ilvRows, p.ilvCols);
    end
    rx = hamming74_decode(rx);
end

nErr  = sum(rx ~= bits);
nBits = numel(bits);
end
