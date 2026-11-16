function bits = hamming74_decode(code)
%HAMMING74_DECODE Hamming(7,4) syndrome decoder (corrects 1 error per codeword).
%
%   code - column of hard-decision coded bits, length a multiple of 7
%   bits - decoded information bits (4 per codeword)
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

P = [1 1 0; 1 0 1; 0 1 1; 1 1 1];
Hm = [P.', eye(3)];                      % 3 x 7 parity-check matrix

R = reshape(code, 7, []).';              % one received word per row
S = mod(R * Hm.', 2);                    % syndromes, one per row
sIdx = S * [4; 2; 1];                    % syndrome as a number 0..7

% Lookup: syndrome value -> position of the single bit in error (0 = none)
errPos = zeros(8, 1);
colVal = [4 2 1] * Hm;                   % syndrome value of each column of H
errPos(colVal + 1) = 1:7;

pos  = errPos(sIdx + 1);
rows = find(pos > 0);
idx  = sub2ind(size(R), rows, pos(rows));
R(idx) = 1 - R(idx);                     % flip the bit in error

bits = reshape(R(:, 1:4).', [], 1);      % systematic: data is the first 4 bits
end
