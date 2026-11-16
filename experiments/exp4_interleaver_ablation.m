%EXP4_INTERLEAVER_ABLATION Design 3 with and without the block interleaver.
%
%   Methodology steps 4 and 6, specific objective 5. Under pulsed jamming a
%   32-symbol burst lands on about five consecutive codewords when there is
%   no interleaver, which Hamming(7,4) cannot correct. With the 49 x 7
%   interleaver the same burst puts at most one error in each codeword.
%   Design 2 is included as the uncoded reference.
%
%   Output: results/data/exp4_interleaver_ablation.mat
%           results/figures/exp4_interleaver_rho<k>.png

setup_paths; p = params(); rng(p.seed);
fprintf('exp4: interleaver on vs off, Eb/N0 = %g dB\n', p.EbN0_dB);

JS     = p.JS_dB;
design = [2 3 4];
rhos   = {0.1, 'worst'};

berSim  = zeros(numel(design), numel(JS), numel(rhos));
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
        jsAt1e5(i, k)   = js_at_ber(JS, berSim(i, :, k), 1e-5);
    end
    fig = plot_ber_curves(JS, berSim(:, :, k), [], names, ...
        sprintf('Interleaver on vs off, pulsed jammer, \\rho = %s', rhoLbl{k}), 'J/S (dB)');
    save_fig(fig, p.figDir, sprintf('exp4_interleaver_rho%d', k));
end

fprintf('\nJ/S (dB) where BER crosses 1e-5, columns = rho %s:\n', strjoin(rhoLbl, ', '));
for i = 1:numel(design)
    fprintf('  %-45s %s\n', names{i}, mat2str(round(jsAt1e5(i, :), 1)));
end
fprintf('Interleaver gain at 1e-5: %s dB\n', mat2str(round(jsAt1e5(2, :) - jsAt1e5(3, :), 1)));
if ~exist(p.dataDir, 'dir'), mkdir(p.dataDir); end
save(fullfile(p.dataDir, 'exp4_interleaver_ablation.mat'), 'JS', 'rhoLbl', 'berSim', 'names', 'jsAt1e5');
