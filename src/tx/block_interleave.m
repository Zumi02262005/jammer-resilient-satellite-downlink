function out = block_interleave(in, nRows, nCols)
%BLOCK_INTERLEAVE Block interleaver: write row by row, read column by column.
%
%   Each block holds nRows codewords of nCols bits. Codewords are written as
%   rows and the block is read out by columns, so consecutive transmitted
%   bits come from different codewords.
%
%   in    - column vector, length a multiple of nRows*nCols
%   nRows - codewords per block (49)
%   nCols - bits per codeword (7)
%   out   - interleaved column vector, same length
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

X = reshape(in, nCols, nRows, []);       % X(c, r, b): bit c of codeword r in block b
out = reshape(permute(X, [2 1 3]), [], 1);   % read r fastest, then c, then b
end
