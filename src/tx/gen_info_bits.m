function bits = gen_info_bits(nBits)
%GEN_INFO_BITS Random information bits (0/1), equally likely.
%
%   nBits - number of information bits
%   bits  - nBits x 1 column of 0/1 values
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

bits = double(rand(nBits, 1) > 0.5);
end
