function y = dsss_despread(r, pn)
%DSSS_DESPREAD Multiply by the PN code and integrate-and-dump per symbol.
%
%   r  - received chip stream, length Ns*N
%   pn - N x 1 PN chips (+1/-1)
%   y  - Ns x 1 decision values (N times the symbol when there is no noise)
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

N = numel(pn);
y = (pn(:).' * reshape(r, N, [])).';
end
