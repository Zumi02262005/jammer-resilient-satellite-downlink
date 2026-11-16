function pb = ber_hamming74_theory(pc)
%BER_HAMMING74_THEORY Approximate decoded BER of hard-decision Hamming(7,4).
%
%   For a single-error-correcting (n, k) block code with channel symbol
%   error probability pc and independent errors, a standard approximation is
%       Pb ~ pc - pc * (1 - pc)^(n-1),   n = 7
%
%   pc - channel error probability per coded symbol
%        (from ber_jammed_theory or ber_pulsed_theory with rate = 4/7)
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

pb = pc - pc .* (1 - pc).^6;
end
