% Graphical User Interface for HIV time-series time-varying parameter
% identification as described in [1]
%
% Files
%   HIVId       - Main GUI file
%   ekf         - Extended Kalman Filter (EKF) [2],[3]
%   ekfid       - Recursive estimation using EKF
%   pf_sir      - Particle Filter - Sample Importance Resample algorithm
%                   (PF) [4]
%   pfid        - Recursive estimation using PF 
%   smoothts    - Smoothing of the data in the least square sense using the
%                   CVX software package [5]
%   modelall    - Standard 3D parametric HIV ODE model see e.g. [6]
%   logmodel0   - Standard 3D parametric HIV ODE model see e.g. [6] of the logarithm form
%   jacmodel0   - Computes the Jacobian of the Standard 3D parametric HIV ODE model
%   _license_     - GNU GENERAL PUBLIC LICENSE
%
% Usage
%   - Load or set parameters to the model.
%     These parameters should be identified previously identified
%     previously e.g. with a global parameter identification method such as
%     Particle Swarm Optimization (PSO). Note that parameter 'b' is
%     time-varying, thus this parameter value will be the initial value of
%     the identification.
%   - Load the dataset
%   - Load or set the initial values. This can by initializing from the
%     dataset or to the steady-state values determined by the parameters,
%     see Tools/init values...
%   - The covariances can be determined using smoothing the dataset in
%     the least square sense. To do this apply Tools/Smoothing
%   - Identfication using EKF or PF can be applied under Tools/Identification 
%
% Examples
%   Two example scenarios are attached to the software in the examples
%   folder
%
% References
%   [1] Hartmann Andras, Susana Vinga and Joao M. Lemos. “Identification of
%       HIV-1 Dynamics - Estimating the Noise Model, Constant and Time-varying
%       Parameters of Long-term Clinical Data.” In proceedings of
%       BIOINFORMATICS, 2012. Feb. 1-4, Vilamoura, Portugal
%       http://kdbio.inesc-id.pt/wiki/lib/exe/fetch.php?media=hivcontrol:bioinformatics_2012_49_cr.pdf
%   [2] Haykin, S.S. Kalman filtering and neural networks. Edited by Eric A
%       Wan and Rudolph Van Der Merve. Wiley-Interscience, 2001.
%   [3] Sarkka, S.T. “Recursive Bayesian inference on stochastic
%       differential equations”. Helsinki University of Technology (Espoo,
%       Finland), 2006. http://lib.tkk.fi/Diss/2006/isbn9512281279/.
%   [4] Doucet, A, S Godsill, and C Andrieu. “On sequential Monte Carlo
%       sampling methods for Bayesian filtering.” Statistics and computing 10,
%       no. 3 (2000): 197–208.
%       http://www.springerlink.com/index/Q6452K2X37357L3R.pdf.
%   [5] Grant, Michael, and Stephen Boyd. “CVX: Matlab Software for
%       Disciplined Convex Programming.” (2008).
%       Available at http://cvxr.com/cvx/
%       http://www.mendeley.com/research/cvx-matlab-software-for-disciplined-convex-programming/.
%   [6] Perelson, Alan S., and Patrick W. Nelson. “Mathematical Analysis of
%       HIV-1 Dynamics in Vivo.” SIAM Review 41, no. 1 (1999): 3.
%       http://link.aip.org/link/SIREAD/v41/i1/p3/s1&Agg=doi.

%   ekf_options - User interface for EKF
%   pf_options  - User interface for PF
