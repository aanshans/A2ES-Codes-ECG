function aubt_export2arff (data, labels, featnames, labelnames, filename)
%
% Exports to Weka's arff format.
%
% 	e.g.:
%     data = [randn(20, 3)+1; randn(20, 3)+2];
%     labels = [ones(20,1); ones(20,1)*2];
%     featnames = {'Feature 1'; 'Feature 2'; 'Feature 3'};
%     labelnames = {'Label 1'; 'Label 2'};
%     aubt_export2arff (data, labels, featnames, labelnames, 'test.arff');
%
%
%   aubt_export2arff (data, labels, [featnames], [labelnames], filename)
%   
%   input:
%   data        feature matrix 
%               (one samples per row and one feature per column)
%   labels      numerical label vector 
%               (1 = first class, 2 = second class, etc.)
%   featnames   char or cell array with featurenames (rowwise)
%               (default: F1..Fn)
%   labelnames  char or cell array with labelnames (rowwise)
%               (default: 1..N)
%   filename    name of output file
%
%
%   2005, Johannes Wagner <johannes.wagner@informatik.uni-augsburg.de>

% number of features
[samplen, featlen] = size (data);
classlen = max (labels);

% create featnames if necessary
if isempty (featnames) | size (featnames, 1) ~= featlen
   featnames = cell (featlen, 1);
   for i = 1:featlen
      featnames{i} = ['F', num2str(i)]; 
   end
end

% convert featnames to char array
if iscell (featnames)
	featnames = char (featnames);
end

% create labelnames if necessary
if isempty (labelnames) | size (labelnames, 1) ~= classlen
    labelnames = cell (classlen, 1);
    for i = 1:classlen
       labelnames{i} = num2str (i); 
    end
end

% convert featnames to char array
if iscell (labelnames)
	labelnames = char (labelnames);
end

% open file
fid = fopen (filename, 'w');

% write header
fprintf (fid, ['@RELATION "', filename, '"\n']);
fprintf (fid, '\n');
for i = 1:featlen
  fprintf (fid, ['@ATTRIBUTE "', strtrim(featnames(i,:)), '" NUMERIC\n']);
end
fprintf (fid,['@ATTRIBUTE Class {']);
for i = 1:classlen-1
    fprintf (fid, ['"' strtrim(labelnames(i,:)) '",']);
end
fprintf (fid, ['"' strtrim(labelnames(i+1,:)) '"}\n']);
fprintf (fid,'\n');

% write data
fprintf(fid, '@DATA\n');
for i = 1:samplen 
  for j = 1:featlen
    fprintf(fid,['%f,'], data(i,j));    
  end
  fprintf(fid, ['"' strtrim(labelnames(labels(i),:)) '"\n']); 
end

% close file
fclose (fid);