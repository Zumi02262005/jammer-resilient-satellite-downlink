function code = hamming74_encode(bits)
%HAMMING74_ENCODE Systematic Hamming(7,4) encoder (generator matrix, mod 2).
%
%   bits - N x 1 information bits, N a multiple of 4
%   code - (7N/4) x 1 coded bits; each codeword is [d1 d2 d3 d4 p1 p2 p3]
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

P = [1 1 0; 1 0 1; 0 1 1; 1 1 1];
G = [eye(4), P];                         % 4 x 7 generator matrix

D = reshape(bits, 4, []).';              % one dataword per row
C = mod(D * G, 2);                       % one codeword per row
code = reshape(C.', [], 1);
end
