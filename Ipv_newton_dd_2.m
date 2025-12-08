function I_array = Ipv_newton_dd(X, V_array, I0_array, T, G)
% Giriş:
% X: [Iph, Io1, Io2, Rsh, Rs, Ns1, Ns2]
% V_array: Voltaj vektörü
% I0_array: Başlangıç akımı (genellikle Iph)
% T: Sıcaklık (Celsius)
% G: Işınım (W/m^2)

% Sabitler
k = 1.38064852e-23;
q = 1.60217646e-19;
T_K = T + 273.15;
Vt_stc = k * T_K / q;
EXP_LIMIT = 50;

% Parametreler (ışınıma göre Iph güncelleniyor)
Iph = X(1) * (G/1000);
Io1 = X(2);
Io2 = X(3);
Rsh = X(4);
Rs  = X(5);
Ns1 = X(6);
Ns2 = X(7);

N = length(V_array);
I_array = zeros(1, N);

for i = 1:N
    v = V_array(i);
    x0 = I0_array;  % Başlangıç tahmini (Iph önerilir)

    f = @(x) Iph - x - ((v + Rs * x) / Rsh) ...
        - Io1 * (exp(min((v + Rs * x)/(Ns1 * Vt_stc), EXP_LIMIT)) - 1) ...
        - Io2 * (exp(min((v + Rs * x)/(Ns2 * Vt_stc), EXP_LIMIT)) - 1);

    fd = @(x) -1 - Rs / Rsh ...
        - (Io1 * Rs / (Ns1 * Vt_stc)) * exp(min((v + Rs * x)/(Ns1 * Vt_stc), EXP_LIMIT)) ...
        - (Io2 * Rs / (Ns2 * Vt_stc)) * exp(min((v + Rs * x)/(Ns2 * Vt_stc), EXP_LIMIT));

    x = x0;
    for n = 1:1000
        x_new = x - f(x) / fd(x);
        if abs(x_new - x) < 1e-9
            break;
        end
        x = max(0, real(x_new));
    end

    if n == 1000
        warning('Newton iterasyonu 1000 adımda yakınsamadı. V = %.2f', v);
    end

    I_array(i) = x;
end
end