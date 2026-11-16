function pb = ber_bpsk_theory(EbN0_dB)
%BER_BPSK_THEORY Theoretical BPSK BER in AWGN: Pb = Q(sqrt(2 Eb/N0)).
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

pb = qfn(sqrt(2 * 10.^(EbN0_dB/10)));
end
