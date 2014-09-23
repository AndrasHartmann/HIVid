function dX = modelall(t,X,p)
% function dX = modelall(t,X,p)
% Standard 3D parametric HIV ODE model see e.g. [1]
%
% Inputs 
%       p:          Parameter vector
%           p(1)    s   - Rate of CD4+ T cells production from precursors
%                         (cell mm^-3 day^-1)
%           p(2)    d   - Uninfected CD4+ T cells death rate (day^-1)
%           p(3)    b   - CD4+ T cells infection rate (particle^-1 mm^3 ...
%                         day^-1)
%           p(4)    miu - Infected CD4+ T cells death rate (day^-1)
%           p(5)    k   - Virus particles production rate by infected T cells
%                         (particle cell^-1 day^-1)
%           p(6)    c   - Free virus particles death rate (day^-1)
%
%       X0:         Initial conditions
%           X0(1)   T0  - Healthy T cells initial count (cells mm^-3)
%           X0(2)   Ti0 - Infected T cells initial count (cells mm^-3)
%           X0(3)   V0  - Virus particles initial count (particles mm^-3)
%
% Returns dX = [dT;dTi;dv], the results of the model equations
%
%           dT/dt = s-d*T-beta*T*niu
%           dTi/dt=beta*T*niu-miu*Ti
%           dniu/dt=k*Ti-c*niu
%
% See also
%   jacmodel0
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

T=X(1);
Ti=X(2);
v=X(3);

s=p(1);
d=p(2);
b=p(3);
miu=p(4);
k=p(5);
c=p(6);

%First set of equations
dT = s - d*T - b*T*v;
dTi = b*T*v - miu*Ti;
dv = k*Ti - c*v;

dX = [dT;dTi;dv];

end
