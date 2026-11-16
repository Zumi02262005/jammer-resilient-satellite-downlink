function js = js_at_ber(JS_dB, ber, target)
%JS_AT_BER J/S (dB) at which a BER curve first rises through a target BER.
%
%   Interpolates log10(BER) linearly between the two sweep points on either
%   side of the target. Returns NaN if the curve never crosses it.
%
%   JS_dB  - vector of J/S sweep values in dB (increasing)
%   ber    - measured BER at each point (zeros are treated as below target)
%   target - target BER, e.g. 1e-5
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

JS_dB = JS_dB(:); ber = ber(:);
js = NaN;
k = find(ber(1:end-1) <= target & ber(2:end) > target, 1, 'first');
if isempty(k), return; end
lo = log10(max(ber(k), 1e-12));
hi = log10(ber(k+1));
js = JS_dB(k) + (log10(target) - lo) / (hi - lo) * (JS_dB(k+1) - JS_dB(k));
end
