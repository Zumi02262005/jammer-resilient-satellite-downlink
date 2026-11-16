%EXP1_AWGN_VALIDATION Designs 1 and 2 with AWGN only, against Q(sqrt(2Eb/N0)).
%
%   Methodology steps 1 and 2. Both curves must sit on the theory curve
%   before any jammer result is trusted: Design 1 checks the noise scaling,
%   Design 2 checks that spreading and despreading leave Eb/N0 unchanged.
%
%   Output: results/data/exp1_awgn_validation.mat
%           results/figures/exp1_awgn_validation.png

setup_paths; p = params(); rng(p.seed);
fprintf('exp1: AWGN validation\n');

EbN0   = p.EbN0_val_dB;
design = [1 2];
jam.type = 'none';

berSim = zeros(numel(design), numel(EbN0));
names  = cell(1, numel(design));
for i = 1:numel(design)
    d = design_info(p, design(i)); names{i} = d.name;
    t0 = tic;
    for k = 1:numel(EbN0)
        p.EbN0_dB = EbN0(k);
        berSim(i, k) = run_ber_point(p, design(i), jam, -Inf);
    end
    fprintf('  %-45s done in %.0f s\n', d.name, toc(t0));
end
berTh = repmat(ber_bpsk_theory(EbN0), numel(design), 1);

fig = plot_ber_curves(EbN0, berSim, berTh, names, ...
    'AWGN validation: simulated BER vs BPSK theory', 'E_b/N_0 (dB)');
save_fig(fig, p.figDir, 'exp1_awgn_validation');
if ~exist(p.dataDir, 'dir'), mkdir(p.dataDir); end
save(fullfile(p.dataDir, 'exp1_awgn_validation.mat'), 'EbN0', 'berSim', 'berTh', 'names');
