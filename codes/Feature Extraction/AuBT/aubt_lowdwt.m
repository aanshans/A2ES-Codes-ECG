function z = aubt_lowdwt (x, flow)
% Performs a single level 1-D discrete lowpass wavelet transform
% without downsampling, i.e. the decomposed signal containing the 
% detaile coefficients has the same size as the input signal x.
%
%  z = aubt_lowdwt (x, flow)
%
%  input:
%  x       the signal
%  flow    lowpass filter
%
%  output:
%  z       detail coefficients obtained by the decomposition of x
%          since the output is not downsampled as usual z has the same
%          length as x!
%
%
% 2005, Johannes Wagner <johannes.wagner@informatik.uni-augsburg.de>

lf = length (flow);
lx = length (x);
lenEXT = lf-1; 
first = lenEXT;
last = lx+lenEXT-1;
y  = x([lf-1:-1:1, 1:lx, lx:-1:lx-lf]);

z = conv2 (y(:)', flow(:)', 'valid'); 
if size (x, 1) > 1
	z = z';
end
z = z(first:last);