%SETUP_PATHS Add project folders to the MATLAB path. Safe to run more than once.
projRoot = fileparts(mfilename('fullpath'));
addpath(projRoot);
addpath(fullfile(projRoot, 'config'));
addpath(genpath(fullfile(projRoot, 'src')));
addpath(fullfile(projRoot, 'experiments'));
addpath(fullfile(projRoot, 'tests'));
clear projRoot;
