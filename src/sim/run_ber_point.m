function [ber, nErr, nBits] = run_ber_point(p, design, jam, JS_dB)
%RUN_BER_POINT Measure BER at one operating point.
%
%   Repeats simulate_link until p.minErrors bit errors have been counted
%   or p.maxBits information bits have been sent, whichever comes first.
%
%   ber   - measured bit error rate (0 if no errors were seen)
%   nErr  - total bit errors counted
%   nBits - total information bits sent
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

nErr = 0; nBits = 0;
while nErr < p.minErrors && nBits < p.maxBits
    [e, n] = simulate_link(p, design, jam, JS_dB);
    nErr  = nErr + e;
    nBits = nBits + n;
end
ber = nErr / nBits;
end
