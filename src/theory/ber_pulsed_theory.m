function pb = ber_pulsed_theory(EbN0_dB, JS_dB, Gp_dB, rho, rate)
%BER_PULSED_THEORY Two-state BER model for a pulsed noise jammer.
%
%   A fraction rho of the symbols sees N0 + J0/rho and the rest see N0:
%       Pb = rho * Q(sqrt(2*rate*Eb/(N0 + J0/rho))) + (1-rho) * Q(sqrt(2*rate*Eb/N0))
%
%   EbN0_dB, JS_dB, Gp_dB, rate - as in ber_jammed_theory
%   rho - duty cycle (0 < rho <= 1), or 'worst' for the duty cycle that
%         maximizes Pb at each J/S (found by a search over rho)
%
%   The model assumes each symbol is either fully jammed or not jammed, and
%   for a coded design it assumes ideal interleaving (independent errors).
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

if nargin < 5, rate = 1; end
EbN0 = 10^(EbN0_dB/10);
EbJ0 = 10.^((Gp_dB - JS_dB(:).')/10);    % row vector over J/S

if ischar(rho)
    rhoGrid = logspace(-5, 0, 600).';    % column vector over rho
    pbAll = two_state(rhoGrid, EbN0, EbJ0, rate);
    pb = max(pbAll, [], 1);
else
    pb = two_state(rho, EbN0, EbJ0, rate);
end
pb = reshape(pb, size(JS_dB));
end

function pb = two_state(rho, EbN0, EbJ0, rate)
snrOn  = rate ./ (1/EbN0 + 1./(rho .* EbJ0));
snrOff = rate * EbN0;
pb = rho .* qfn(sqrt(2*snrOn)) + (1 - rho) .* qfn(sqrt(2*snrOff));
end
