%EXP2_TONE_JAMMER BER vs J/S under the continuous-wave (tone) jammer.
%
%   Methodology steps 3 to 6. Runs Designs 1, 2 and 3 at each tone offset
%   in p.toneOffsets and overlays the Gaussian-equivalent theory,
%   Pb = Q(sqrt(2 Eb/(N0 + J0))) with Eb/J0 = Gp - J/S. A tone is not
%   Gaussian, so the gaps between simulation and theory are the R6
%   discussion: the 31 chips of the PN code sum to +/-1, so a tone at the
%   carrier is suppressed far more than Gp predicts.
%
%   Output: results/data/exp2_tone_jammer.mat
%           results/figures/exp2_tone_offset<k>.png (one per offset)

setup_paths; p = params(); rng(p.seed);
fprintf('exp2: tone jammer, Eb/N0 = %g dB\n', p.EbN0_dB);

JS      = p.JS_dB;
design  = [1 2 3];
offsets = p.toneOffsets;

% Theory does not depend on the tone offset
berTh = zeros(numel(design), numel(JS));
names = cell(1, numel(design));
for i = 1:numel(design)
    d = design_info(p, design(i)); names{i} = d.name;
    pc = ber_jammed_theory(p.EbN0_dB, JS, lin2db(d.GpEff), d.rate);
    if d.coded, pc = ber_hamming74_theory(pc); end
    berTh(i, :) = pc;
end

berSim  = zeros(numel(design), numel(JS), numel(offsets));
jsAt1e5 = zeros(numel(design), numel(offsets));
for k = 1:numel(offsets)
    fprintf(' Tone offset = %g x symbol rate\n', offsets(k));
    jam.type = 'tone'; jam.fOffsetSym = offsets(k);
    for i = 1:numel(design)
        berSim(i, :, k) = sweep_js(p, design(i), jam);
        jsAt1e5(i, k)   = js_at_ber(JS, berSim(i, :, k), 1e-5);
    end
    fig = plot_ber_curves(JS, berSim(:, :, k), berTh, names, ...
        sprintf('Tone jammer, offset = %g x symbol rate, E_b/N_0 = %g dB', ...
        offsets(k), p.EbN0_dB), 'J/S (dB)');
    save_fig(fig, p.figDir, sprintf('exp2_tone_offset%d', k));
end

fprintf('\nJ/S (dB) where BER crosses 1e-5 (NaN = never crossed in the sweep):\n');
for i = 1:numel(design)
    fprintf('  %-45s %s\n', names{i}, mat2str(round(jsAt1e5(i, :), 1)));
end
if ~exist(p.dataDir, 'dir'), mkdir(p.dataDir); end
save(fullfile(p.dataDir, 'exp2_tone_jammer.mat'), 'JS', 'offsets', 'berSim', 'berTh', 'names', 'jsAt1e5');
