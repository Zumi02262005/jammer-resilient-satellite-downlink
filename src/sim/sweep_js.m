function ber = sweep_js(p, design, jam)
%SWEEP_JS Measure BER at every J/S value in p.JS_dB for one design and jammer.
%
%   ber - 1 x numel(p.JS_dB) vector of measured BER
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

d = design_info(p, design);
ber = zeros(1, numel(p.JS_dB));
t0 = tic;
for k = 1:numel(p.JS_dB)
    ber(k) = run_ber_point(p, design, jam, p.JS_dB(k));
end
fprintf('  %-45s done in %.0f s\n', d.name, toc(t0));
end
