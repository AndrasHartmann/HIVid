function estimates = ekfid(X0, params, Q, R, y, ts)
% function estimates = ekfid(X0, params, Q, R, y, ts)
% EKF initialization and recursion
%
% Input
%   X0  - Initial values 
%   Q   - Measurement noise covariances 
%   R   - Process noise covariances 
%   y   - Measurement data
%   ts  - Time instances
%
% Returns estimated values of time-series.
%
% see also
%   ekf, pfid
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

ylog = log(y);
notexist = find(y==-1);
ylog(notexist) = y(notexist);

%mdel dimensions as defined in the model
%number of states
n = 3;
%number of observed states
m = 2;
%number of
ni = 4;

X0_param = [log(X0(:)); params(3)];

%initial covariances
%P = eye(ni);
P = diag((X0_param).^2);
P(end) = 10^-9;
% measurement equation: only the sum of the first two states are observed
%h=@(tao,x)[(x(1)+x(2)); (x(3))];

h=@(tao,x)[log(exp(x(1))+exp(x(2))); (x(3))];

% Jacobian of the measurement equation
%H = [1 1 0 0; 0 0 1 0];
H =@(x) [exp(x(1))/(exp(x(1))+exp(x(2))) exp(x(2))/(exp(x(1))+exp(x(2))) 0 0; 0 0 1 0];


%identifying with EKF

maxk=length(ts);
%waitbar initialization
wb = waitbar(0, sprintf('Extended Kalman Filter is runninng... \n Please wait'));

xp = X0_param;

estimates = zeros(ni,maxk);

% EKF recursion
estimates(:,1) = xp;
for k=2:maxk
    waitbar(k/maxk,wb);
    %update parameters
    params(3) = xp(4);
    [xp, P] = ekf(@logmodel0, @jaclogmodel0, h, H, xp, ylog(:,k), ni, m, P, R, Q, ts(k)-ts(k-1), params);
    %xp(xp<=0)=10^-15;%just in case we would go negative ...  % FIXME: could be a warning if this happens
    if (xp(end)<=0)
        xp(end)=10^-15;
    end;
    estimates(:,k) = xp;
end

close(wb);

%plotting

%time-varying parameter
figure(1);
close;
figure(1);
plot(ts, estimates(4,:));
xlimit = get(gca,'xlim');
set(gca,'ylim', [0 3*10^-5]);
set(gca,'xlim', [-20 xlimit(2)]);
set(gca,'xgrid', 'on', 'ygrid', 'on');
title('Time-varying parameter ')

%estimeates: only the observed values
yhat = [(exp(estimates(1,:)) + exp(estimates(2,:))); exp(estimates(3,:))];

%state estimates
figure(2);
close;
figure(2);
subplot(2,1,1)
semilogy(ts,y(2,:),'o')
hold on;
semilogy(ts,yhat(2,:),'.--')
ylabel('V');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
set(gca,'xlim', [-10 ts(end)+10]);
set(gca,'ylim', [10 200000]);
set(gca,'ytick', [10 1000 100000]);
title('State estimates');

subplot(2,1,2)
plot(ts,y(1,:),'o')
ylabel('T+T^*');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
hold on;
plot(ts,yhat(1,:),'.--')
set(gca,'ylim', [200 1000]);
set(gca,'xlim', [-10 ts(end)+10]);
