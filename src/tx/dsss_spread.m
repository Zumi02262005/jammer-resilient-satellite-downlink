function chips = dsss_spread(sym, pn)
%DSSS_SPREAD Multiply each symbol by the PN code (same code every symbol).
%
%   sym   - Ns x 1 BPSK symbols (+1/-1)
%   pn    - N x 1 PN chips (+1/-1)
%   chips - (Ns*N) x 1 chip stream
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

chips = reshape(pn(:) * sym(:).', [], 1);   % column k = pn * sym(k)
end
