function xpost1 = pf_sir(f, h, xpost, y, n, ni, m, Q, mu, t, params)
% function xpost1 = pf_sir(f, h, xpost, y, n, ni, m, Q, mu, t, params)
% Sample Importance Resampling (SIR)
% The function corresponds to one Particle Filter recursion step
% consisting from one time update and measurement update.
%
% Parameters
%    f          - Parametric ODE model function
%    h          - Observation model
%    xpost      - Initial value, or previous estimates in the recursion
%    y          - Observation vector
%    n          - Number of states
%    ni         - Number of states extended with parameters
%    m          - Length of observation vector
%    Q          - Measurement noise covariances 
%    mu         - Covariance of noise to add to to the states at every step,
%                 useful at identification when there is no parameter evolution
%    t          - Length of the step
%    params     - ODE parameters
%
% returns
%    xp1 are the updated state estimates and P1 is the updated covariance 
%
% see also
%    ekfid, ekf
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

%replacement factor for particles (not used in this scenario)
rf = 0.0;
%added parameter noise
pn = 10^-7;

%Number of particles
N = size(xpost,2);

xpre = zeros(ni,N);      %pre
xpost1 = zeros(ni,N);      %post

%Vector of weights
qu = zeros(N,1);

%apposteriori pdf (which was actually appriori in the previous step)
xpost(1:n,:) = abs(xpost(1:n,:))+randn(n,N)*rf;
xpost(1:n,:)= zeronegs(xpost(1:n,:));

%adding random walk to the parameters
xpost(n+1:ni,:) = abs(xpost(n+1:ni,:) + mu*randn(ni-n,N));%/mu;

paramsn = repmat(params, 1, N);
paramsn(3,:) = xpost(4,:);
%solving the equation with the parameter set 
%parfor is used here to be able to use multithread
parfor i = 1:N
    [tsim, Xsim] = ode23s(f, [0 t], xpost(1:3,i), [], paramsn(:,i));
    xpre(:,i) = [Xsim(end,:)'; xpost(4,i)];
end;
% some correction, just in case
% FIXME: could be a warning here
xpre(1:n,:)= real(xpre(1:n,:));
xpre(1:n,:)= zeronegs(xpre(1:n,:));

%calculating the weights
for i = 1:N
    hx = h(t,xpre(:,i));
    hx(y==-1) = -1;
    % division by 100 to avoid having too large values
    qu(i) = exp(-((y-hx)'/(Q)*(y-hx))/100);
end;

% Number of effective particles (could be a condition)
%    neff =1/sum(qu.^2)
%    if neff < N/3

qsum = sum(qu);
qu = qu./qsum;

%Resampling
for i = 1:N
    rnum = rand;
    qsum = 0;
    j = 0;
    while qsum < rnum
        j=j+1;
        qsum = qsum+qu(j);
    end;
    xpost1(:,i) = xpre(:,j);
end;
%    end;
