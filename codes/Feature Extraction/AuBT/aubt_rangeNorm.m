function [data_, fnorm] = aubt_rangeNorm (data, a, b)
% Expects as input a matrix and normalizes each column
% into the interval [a b].
%
%  data = aubt_rangeNorm (data, a, b)
%   
%   input:
%   data:    matrix with input values
%   a:       lower interval boundary (default: 0)
%   b:       upper interval boundary (default: 1)
%
%   output:
%   data_:   columnwise normalized matrix
%   fnorm:   function to normalization function
%
%   2006, Johannes Wagner <johannes.wagner@informatik.uni-augsburg.de>

if nargin < 3
    a = 0;
    b = 1;
end

minv = min (data);
maxv = max (data);

fnorm = @(x) ((x - repmat (minv, size (x, 1), 1) ) .* (b-a) ./ (repmat (maxv, size (x, 1), 1) - repmat (minv, size (x, 1), 1))) + a;

data_ = fnorm (data);

