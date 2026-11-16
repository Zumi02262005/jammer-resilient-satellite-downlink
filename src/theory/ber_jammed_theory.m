function pb = ber_jammed_theory(EbN0_dB, JS_dB, Gp_dB, rate)
%BER_JAMMED_THEORY BER with the jammer treated as extra Gaussian noise.
%
%   After despreading, a jammer of power J spread over the chip band leaves
%   a density J0 with Eb/J0 = Gp - J/S (dB). The symbol error probability is
%       Pb = Q( sqrt( 2 * rate * Eb / (N0 + J0) ) )
%
%   EbN0_dB - Eb/N0 in dB (scalar)
%   JS_dB   - J/S in dB (vector)
%   Gp_dB   - processing gain in dB: 0 for plain BPSK, 10*log10(31) for
%             DSSS, 10*log10(31*7/4) for the coded design (wider band)
%   rate    - code rate (default 1). With rate < 1 the result is the
%             channel (coded-symbol) error probability, before decoding;
%             pass it to ber_hamming74_theory for the decoded BER.
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

if nargin < 4, rate = 1; end
EbN0 = 10^(EbN0_dB/10);
EbJ0 = 10.^((Gp_dB - JS_dB)/10);
snr  = rate ./ (1/EbN0 + 1./EbJ0);       % Es / (N0 + J0)
pb   = qfn(sqrt(2 * snr));
end
