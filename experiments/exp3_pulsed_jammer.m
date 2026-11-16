%EXP3_PULSED_JAMMER BER vs J/S under pulsed noise jamming at each duty cycle.
%
%   Methodology steps 3 to 6. Runs Designs 1, 2 and 3 for every duty cycle
%   in p.rhoList plus the worst-case duty cycle, and overlays the two-state
%   theory (ber_pulsed_theory). rho = 1 is continuous noise jamming, where
%   the Gaussian theory should match closely (Hand Calculation 2: about
%   -13.3 dB for Design 1 and +1.6 dB for Design 2 at BER = 1e-5).
%
%   Output: results/data/exp3_pulsed_jammer.mat
%           results/figures/exp3_pulsed_rho<k>.png (one per duty cycle)

setup_paths; p = params(); rng(p.seed);
fprintf('exp3: pulsed jammer, Eb/N0 = %g dB\n', p.EbN0_dB);

JS     = p.JS_dB;
design = [1 2 3];
rhos   = [num2cell(p.rhoList), {'worst'}];

berSim  = zeros(numel(design), numel(JS), numel(rhos));
berTh   = zeros(numel(design), numel(JS), numel(rhos));
jsAt1e5 = zeros(numel(design), numel(rhos));
names   = cell(1, numel(design));
rhoLbl  = cell(1, numel(rhos));
for k = 1:numel(rhos)
    rho = rhos{k};
    if ischar(rho), rhoLbl{k} = 'worst case'; else, rhoLbl{k} = sprintf('%g', rho); end
    fprintf(' Duty cycle rho = %s\n', rhoLbl{k});
    jam.type = 'pulsed'; jam.rho = rho;
    for i = 1:numel(design)
        d = design_info(p, design(i)); names{i} = d.name;
        berSim(i, :, k) = sweep_js(p, design(i), jam);
        pc = ber_pulsed_theory(p.EbN0_dB, JS, lin2db(d.GpEff), rho, d.rate);
        if d.coded, pc = ber_hamming74_theory(pc); end
        berTh(i, :, k) = pc;
        jsAt1e5(i, k)  = js_at_ber(JS, berSim(i, :, k), 1e-5);
    end
    fig = plot_ber_curves(JS, berSim(:, :, k), berTh(:, :, k), names, ...
        sprintf('Pulsed jammer, \\rho = %s, E_b/N_0 = %g dB', rhoLbl{k}, p.EbN0_dB), 'J/S (dB)');
    save_fig(fig, p.figDir, sprintf('exp3_pulsed_rho%d', k));
end

fprintf('\nJ/S (dB) where BER crosses 1e-5, columns = rho %s:\n', strjoin(rhoLbl, ', '));
for i = 1:numel(design)
    fprintf('  %-45s %s\n', names{i}, mat2str(round(jsAt1e5(i, :), 1)));
end
if ~exist(p.dataDir, 'dir'), mkdir(p.dataDir); end
save(fullfile(p.dataDir, 'exp3_pulsed_jammer.mat'), 'JS', 'rhoLbl', 'berSim', 'berTh', 'names', 'jsAt1e5');
