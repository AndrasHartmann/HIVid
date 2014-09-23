function yhat = smoothts(data, reg)
% function yhat = smoothts(data, reg)
% Smoothing of the data in the least square sense taking into account the smoothness till the 4th derivative using the CVX software package
%
% Input
%   data - input data, where the first column are measurement times instances (design) and the second column the measured values
%   reg  - the regularization (weight) of the derivatives at the smooting process, the default value is 0.2 .
%
% Returns yhat, the smoothed estimate
%
%Copyright (C) 2012  Andras Hartmann <ahartmann@kdbio.inesc-id.pt>
%
% This file is part of HIVId.
% 
% HIVId is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation version 3.
% 
% HIVId is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with HIVId. If not, see http://www.gnu.org/licenses/.

%default value of the regularizing parameter
if nargin<2
    reg = 0.2;
end

n = length(data(:,1));
e = ones(n,1);
D = spdiags([-e e], -1:0, n, n);
D(1) = 0;

dt = ones(n,1);

cvx_begin
	variable yhat(n)
	minimize norm(data(:,2)-yhat,2) +reg*norm(D*yhat.*dt,2) + reg*norm(D*D*yhat.*dt,2) +reg*norm(D*D*D*yhat.*dt,2) + reg*norm(D*D*D*D*yhat.*dt,2)
cvx_end
