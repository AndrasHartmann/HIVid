function out = preprocess(data)
%removing non-existent and non-detectable values

x = data(:,1); 
y = data(:,2); 

%ys = sort(y)
%find all replicates and delete them
%rep = [];
%for i = 1:length(y)-1
%	if ys(i) == ys(i+1) 
%		rep = [rep ys(i)]
%	end
%end
%rep = unique(rep)

%remove elements of rep from the time-series

%We do not need to delete points that are under the treshold
%rep = [-1];% 5.01187234e+001];
rep = [-1 5.01187234e+001];

for i=1:length(rep)
	unav = find (y == rep(i));
	x(unav) = [];
	y(unav) = [];
end

out = [x,y];
