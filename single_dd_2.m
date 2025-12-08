%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Dr.Tummala.S.L.V.Ayyarao
%% https://scholar.google.co.in/citations?user=X7i25FAAAAAJ&hl=en&oi=sra
%% GMR Institute of Technology, India
%% Ayyarao, TummalaS LV, N. S. S. RamaKrishna, Rajvikram Madurai Elavarasam, Nishanth Polumahanthi, M. Rambabu, Gaurav Saini, Baseem Khan, and Bilal Alatas. "War Strategy Optimization Algorithm: A New Effective Metaheuristic Algorithm for Global Optimization." IEEE Access (2022).
%% https://ieeexplore.ieee.org/abstract/document/9718247
%% Code developed by Tummala.S.L.V.Ayyarao
%% Ayyarao, Tummala SLV, and Polamarasetty P. Kumar. "Parameter estimation of solar PV models with a new proposed war strategy optimization algorithm." International Journal of Energy Research (2022).
%% https://onlinelibrary.wiley.com/doi/abs/10.1002/er.7629
%% Ayyarao, Tummala SLV. "Parameter estimation of solar PV models with quantum-based avian navigation optimizer and Newton–Raphson method." Journal of Computational Electronics (2022): 1-19.
%%  Parameter extraction of DDM
function J = single_dd_2(X)
global V Ie Im
% k=1.38064852*10^(-23);
% q=1.60217646*10^(-19);
% Iph_e=X(1);
% % Iph=0.7608;
% Id_e=X(2);
% % Id=0.3223*10^-6;
% N=1.4837;
% Rsh_e=X(3);
% % Rsh=1/0.0186;
% % Rs=0.0364;
% Rs_e=X(4);
% T=306.15;
% alpha_e=X(5);
% % alpha=N;
J1=0;
Im=[1.9098,1.9098,1.9098,1.9098,1.9098,1.9098,1.9098,1.90818,1.90911,1.905051,1.903,1.899,1.89299,1.87526,1.866,1.827,1.774,1.65267,1.52,1.321,1.19,1.031,0.84,0.609,0.332,0];
V=[0,0.497,0.994,1.989,3.23,4.72,11.937,16.1646,16.9107,17.9055,18.15,18.6515,19.1489,19.8949,20.1436,20.84,21.3871,22.1331,22.63,23.1279,23.3766,23.62,23.87,24.1226,24.37,24.62];
for i=1:26
Ie(i)=Ipv_newton_dd(X,V(i),Im(i));
if isnan(Ie(i))
    Ie(i)=100;
end
e=(Im(i)-Ie(i))^2;
J1=J1+e;
end
J=sqrt(1/26*J1);
end
