function out = block_deinterleave(in, nRows, nCols)
%BLOCK_DEINTERLEAVE Inverse of block_interleave.
%
%   in    - interleaved column vector, length a multiple of nRows*nCols
%   nRows - codewords per block (49)
%   nCols - bits per codeword (7)
%   out   - column vector in the original codeword order
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

Y = reshape(in, nRows, nCols, []);       % Y(r, c, b)
out = reshape(permute(Y, [2 1 3]), [], 1);   % back to c fastest, then r, then b
end
