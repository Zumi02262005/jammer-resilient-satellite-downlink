function p = params()
%PARAMS Simulation parameters for all experiments (values from the proposal).

% Reproducibility
p.seed         = 42;

% Spreading code: 31-chip m-sequence from a 5-stage LFSR
p.pnStages     = 5;
p.pnTaps       = [5 2];
p.pnSeed       = [0 0 0 0 1];
p.N            = 2^p.pnStages - 1;     % chips per symbol (31)
p.Gp_dB        = 10*log10(p.N);        % processing gain (14.9 dB)

% Coding and interleaving
p.codeN        = 7;                    % Hamming(7,4)
p.codeK        = 4;
p.rate         = p.codeK / p.codeN;    % 4/7, so Ec = (4/7) Eb
p.ilvRows      = 49;                   % codewords per interleaver block
p.ilvCols      = 7;                    % bits per codeword

% Operating point and sweeps
p.EbN0_dB      = 12;                   % fixed during the J/S sweep
p.JS_dB        = -30:1:15;             % J/S sweep
p.EbN0_val_dB  = 0:1:10;               % AWGN validation sweep

% Jammers
p.toneOffsets  = [0, 1, 0.5];          % tone offset from carrier, in multiples of the symbol rate:
                                       % at the carrier, on a PN spectral line, between lines
p.rhoList      = [1, 0.3, 0.1];        % pulsed duty cycles ('worst' is also supported)
p.pulseLenSyms = 32;                   % pulse length in transmitted (coded) symbols

% Monte Carlo stopping rule
p.batchBits    = p.codeK * p.ilvRows * 100;   % info bits per batch (19600, whole interleaver blocks)
p.minErrors    = 100;
p.maxBits      = 1e7;

% Output folders
root           = fileparts(fileparts(mfilename('fullpath')));
p.dataDir      = fullfile(root, 'results', 'data');
p.figDir       = fullfile(root, 'results', 'figures');
end
