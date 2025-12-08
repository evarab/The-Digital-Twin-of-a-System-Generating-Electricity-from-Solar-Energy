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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc
format long;
warning('off','all')

SearchAgents_no = 50; % Agent sayısı
Max_iteration = 500;   % Maksimum iterasyon

fobj = @single_dd_2;
lb = [1.7, 1e-10, 1e-13, 100, 0, 30, 30];
ub = [3.5, 1e-6, 1e-8, 1000, 1, 80, 80];
dim = 7;

global V Ie Im 
BEst=zeros(1,10);
BEst1=inf;

for i = 1:1
    [Best_score, Best_pos, WSO_cg_curve] = WSO(SearchAgents_no, Max_iteration, lb, ub, dim, fobj);
end

%% === GRAFİKLER ===

% 1️⃣ ITERASYON EĞRİSİ
figure(1)
semilogy(WSO_cg_curve, 'Color', 'r')
xlabel('İterasyon')
ylabel('En iyi skor')
title('İterasyon Başarımı')
axis tight
grid on
box on

% 2️⃣ I-V EĞRİSİ
single_dd_2(Best_pos); % Bu fonksiyon içinde Ie vektörü hesaplanıyor
figure(2)
plot(V, Im, 'k', 'LineWidth', 1.5); hold on
plot(V, Ie, 'ro', 'MarkerSize', 6)
xlabel('Voltaj (V)')
ylabel('Akım (A)')
legend('Gerçek Veri', 'Model Eğrisi')
title('I-V Eğrisi')
grid on

% 3️⃣ P-V EĞRİSİ (Model Eğrisi ile)
Voc = 25;                                 % Açık devre gerilimi (paneline göre ayarla)
V_model = linspace(0, Voc, 100);          % Voltaj aralığı
I_model = zeros(size(V_model));
P_model = zeros(size(V_model));

for i = 1:length(V_model)
    I_model(i) = Ipv_newton_dd(Best_pos, V_model(i), Best_pos(1)); % I0 yerine Iph = Best_pos(1)
    P_model(i) = V_model(i) * I_model(i);
end

figure(3)
plot(V_model, P_model, 'b', 'LineWidth', 2); hold on

% Gerçek güç değerleri:
P_real = V .* Im;  % Noktasal gerçek güç = V x I

plot(V, P_real, 'ko', 'MarkerSize', 6, 'LineWidth', 1.2)  % Gerçek veri noktaları

xlabel('Voltaj (V)');
ylabel('Güç (W)');
legend('Model (Tahmin)', 'Gerçek Veri');
title('P-V Eğrisi');
grid on


