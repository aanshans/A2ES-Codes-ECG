function data_ = aubt_varNorm (data, meanVal, stdVal)
% Expects as input a signal vector and normalizes it 
% by its mean and std value.
%
%  data_ = aubt_varNorm (data, [meanVal], [stdVal])
%   
%   input:
%   data:     signal vector
%   meanVal:  mean used for normalization (optional)
%   stdVal:   std used for normalization (optional)
%
%   output:
%   data_:    matrix containing normalized values
%
%   2005, Johannes Wagner <johannes.wagner@informatik.uni-augsburg.de>

if nargin < 2 | isempty (meanVal)
	meanVal = mean (data);
end

if nargin < 3 | isempty (stdVal)
	stdVal = std (data);
end

data_ = (data - repmat (meanVal, size (data, 1), 1)) ./ repmat (stdVal, size (data, 1), 1);
