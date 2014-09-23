function estimates = pfid(X0, params, Q, R, y, ts, N)
% function estimates = pfid(X0, params, Q, R, y, ts, N)
% PF initialization and recursion
%
% Input
%   X0  - Initial values 
%   Q   - Measurement noise covariances 
%   R   - Process noise covariances 
%   y   - Measurement data
%   ts  - Time instances
%   N   - Number of particles
%
% Returns estimated values of time-series.
% 
% see also
%   pf_sir, ekfid
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


%script for identification of 1 time varying parameter: beta, and the states usin PF
% addpath ../models

ylog = log(y);
notexist = find(y==-1);
ylog(notexist) = y(notexist);

%identification

%model dimensions
%number of states
n = 3;
%number of observed states
m = 2;
%number of
ni = 4;

%Initial conditions
X0_param = [log(X0(:)); params(3)];

%Guessing initial covariances
P = eye(ni)*0.000000001;
X0diff = [ log(X0(:))'-log([y(1,1)*0.8 y(1,1)*0.2 y(2,1)]*0.9), 0.5*10^-7];

%Addtional diagonal constant
P = X0diff'*X0diff+P;

% measurement equation: only the sum of the first two states are observed
%h=@(tao,x)[(x(1)+x(2)); (x(3))];

h=@(tao,x)[log(exp(x(1))+exp(x(2))); (x(3))];

%identifying with PF

maxk=length(ts);
%waitbar initialization
wb = waitbar(0, sprintf('Particle Filter is runninng... \n Please wait'));

estimates = zeros(ni,maxk);

%initialization
xpost = abs(repmat(X0_param,1,N)+chol(P)'*randn(ni,N));

%alternatively it could be made like this...
%initialization
%xpost = pf_sir(@logmodel1, h, xpost, ylog(:,1), n, ni, m, Q, 10^-5*sqrt(0.3), 0.3);
%    xp = mean(xpost,2);
%    xp(xp<=0)=10^-15;%if we would go negative ...
%    estimates(:,1)=xp;

estimates(:,1) = X0_param;

%PF recursion
for k = 2:maxk
    waitbar(k/maxk,wb);
    xpost = pf_sir(@logmodel0, h, xpost, ylog(:,k), n, ni, m, Q,  10^-7*sqrt(ts(k)-ts(k-1)), ts(k)-ts(k-1), params);
    xp = mean(xpost,2);
    xp(xp<=0)=10^-15;%just in case we would go negative ...  % FIXME: could be a warning if this happens
    estimates(:,k)=xp;
end;

close(wb);

%plotting
%FIXME: plotting copy pasted from ekfid, it could be separated to a function...

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
