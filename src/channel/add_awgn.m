function [r, sigma2] = add_awgn(x, EsN0_dB, samplesPerSym)
%ADD_AWGN Add real white Gaussian noise for a given Es/N0.
%
%   The signal has unit power per sample, so one transmitted symbol has
%   energy Es = samplesPerSym. Real noise with density N0 has variance
%   N0/2 per sample, so sigma^2 = samplesPerSym / (2 * Es/N0).
%
%   x             - transmitted samples (+1/-1)
%   EsN0_dB       - energy per transmitted symbol over N0, in dB
%                   (Es/N0 = rate * Eb/N0 for a coded design)
%   samplesPerSym - chips per symbol (1 for unspread BPSK)
%   r             - noisy samples
%   sigma2        - noise variance per sample
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

sigma2 = samplesPerSym / (2 * 10^(EsN0_dB/10));
r = x + sqrt(sigma2) * randn(size(x));
end
