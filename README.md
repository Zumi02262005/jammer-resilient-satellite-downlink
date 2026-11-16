# Jammer-Resilient Satellite Downlink in MATLAB

DIGDACM term project (Track A, simulation). Juan Carlos P. Pajarillo.

Compares three BPSK satellite-downlink designs under tone (CW) and pulsed jamming:

1. Plain BPSK
2. DSSS-BPSK with a 31-chip PN code
3. DSSS-BPSK with Hamming(7,4) coding and a 49 x 7 block interleaver (design 4 = design 3 without the interleaver)

Metric: BER vs J/S at a fixed Eb/N0 of 12 dB, compared with theory.

## Requirements

- MATLAB (base). The Communications Toolbox is not required.

## How to run

1. Open MATLAB in this folder.
2. `setup_paths` adds all folders to the path.
3. `run_tests` checks the building blocks.
4. `main_run_all` runs every experiment and writes all figures (slow).
5. `demo_quick` is the short version for the live demo.

All scripts call `rng(42)`, so results are reproducible.

## Folder layout

| Folder | Contents |
| --- | --- |
| `config/` | `params.m`: every simulation parameter in one place |
| `src/tx/` | Bit source, Hamming encoder, interleaver, BPSK mapper, PN generator, spreader |
| `src/channel/` | AWGN, tone jammer, pulsed jammer |
| `src/rx/` | Despreader (integrate and dump), hard decision, deinterleaver, Hamming decoder |
| `src/sim/` | One-batch link simulation and the BER stopping rule |
| `src/theory/` | Theoretical BER curves for AWGN, Gaussian-equivalent jamming, pulsed jamming |
| `src/utils/` | dB conversions |
| `experiments/` | One script per report figure (exp1 to exp4) |
| `tests/` | Unit tests for the building blocks |
| `results/` | Saved `.mat` data and `.png` figures (generated) |
| `docs/` | Block diagram (Figure 1) |

## Figure map

| Figure | Script |
| --- | --- |
| AWGN validation | `experiments/exp1_awgn_validation.m` |
| BER vs J/S, tone jammer | `experiments/exp2_tone_jammer.m` |
| BER vs J/S, pulsed jammer | `experiments/exp3_pulsed_jammer.m` |
| Interleaver on vs off | `experiments/exp4_interleaver_ablation.m` |
