function j = jammer_tone(nSamples, JS_dB, fOffsetNorm, phase)
%JAMMER_TONE Continuous-wave (tone) jammer at a set J/S, after chip filtering.
%
%   A passband tone of power J at an offset from the carrier appears, after
%   coherent demodulation, as sqrt(J/S)*cos(2*pi*f*t + phase) next to chips
%   of amplitude 1. Each output sample is that tone averaged over one chip
%   (the rectangular chip matched filter), which gives a sinc(f) factor.
%
%   nSamples    - number of chip samples
%   JS_dB       - jammer-to-signal power ratio in dB (signal power = 1)
%   fOffsetNorm - tone offset from the carrier, in cycles per chip
%   phase       - tone phase in radians (drawn at random per batch)
%   j           - nSamples x 1 jammer samples
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

A = sqrt(10^(JS_dB/10));
f = fOffsetNorm;
if f == 0
    att = 1;
else
    att = sin(pi*f) / (pi*f);            % sinc(f) without the toolbox function
end
n = (0:nSamples-1).';
j = A * att * cos(2*pi*f*(n + 0.5) + phase);
end
