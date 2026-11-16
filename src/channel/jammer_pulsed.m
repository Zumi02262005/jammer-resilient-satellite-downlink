function [j, onMask] = jammer_pulsed(nSamples, JS_dB, rho, pulseLen)
%JAMMER_PULSED Pulsed Gaussian noise jammer with average power J.
%
%   The jammer is on for a fraction rho of the time. While on, its power is
%   J/rho, so the average power stays J. In this real baseband model a
%   jammer of power J spread over the chip band has variance (J/S)/2 per
%   sample (the same convention as N0/2 for thermal noise), which makes
%   Eb/J0 = Gp / (J/S).
%
%   Pulses repeat with period pulseLen/rho samples and a random start.
%
%   nSamples - number of chip samples
%   JS_dB    - average jammer-to-signal ratio in dB
%   rho      - duty cycle, 0 < rho <= 1 (rho = 1 is continuous noise jamming)
%   pulseLen - pulse length in samples
%   j        - nSamples x 1 jammer samples
%   onMask   - logical mask, true where the jammer is on
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

JS = 10^(JS_dB/10);
if rho >= 1
    onMask = true(nSamples, 1);
    rho = 1;
else
    period = pulseLen / rho;                     % may be non-integer
    start  = rand * period;                      % random pulse phase
    t      = mod((0:nSamples-1).' + start, period);
    onMask = t < pulseLen;
end
j = zeros(nSamples, 1);
nOn = nnz(onMask);
j(onMask) = sqrt(JS / (2*rho)) * randn(nOn, 1);
end
