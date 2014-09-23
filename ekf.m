function [xp1, P1] = ekf(f, fjac, h, H, xp, y, n, m, P, R, Q, t, params)
% function [xp1, P1] = ekf(f, fjac, h, xp, y, n, m, P, R, Q, t, params)
% One EKF recursion step on continous data and discrete measurement using parametric ODE model
% consisting from one time update and measurement update
% 
% Parameters
%    f      - Parametric ODE model function
%    fjac   - Jacobian function of f with respect to the parameters
%    h      - Observation model
%    H      - Jacobian of h
%    xp     - Initial value, or previous estimates in the recursion
%    y      - Observation vector
%    n      - Number of states
%    m      - Length of observation vector
%    P      - Initial covariance, or previous covariance in the recursion
%    Q      - Measurement noise covariances
%    R      - Process noise covariances
%    t      - Length of the step
%    params - constant ODE model parameters
%
%returns
%    xp1 are the updated state estimates and P1 is the updated covariance 
%
%see also
%    pfid, ekf
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

[tsim, Xsim] = ode23s(f, [0 t], xp(1:3), [], params);
x1 = [Xsim(end,:)'; xp(4:end)];
A = fjac(t, xp(1:3), params);

P_ = A*P*A'+R;

%measurement update
%y1 = H*x1;    

y1 = h(t, x1);
%-1 here means no data available
notexist = find(y==-1);
y(notexist) = y1(notexist);

%nonlinear measurement and linearization around x1
Hx1 = H(x1);

S = Hx1*P_*Hx1'+Q;
K = P_*Hx1'/(S);
xp1 = x1+K*(y-y1);
P1 = (eye(n)-K*Hx1)*P_;
