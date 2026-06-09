
clear; close all; clc;

% Características de las espiras
nI = 5; % Número de espiras
N = 50; % Puntos por espira
R = 1.5; % Radio de cada espira (m)
R2 = 0.50;
sz = 1; % Separación entre espiras (m)
I = 300; % Corriente (A) %CIERTA CANTIDAD DE ESPIRAS * 
N_vueltas = 200;
I_efectiva =  I * N_vueltas 
mo = 4*pi*1e-7; % Permeabilidad magnética del vacío
km = mo * I_efectiva / (4*pi); % Constante de Biot-Savart
rw = 0.2; % Grosor efectivo del alambre

[x, y, z, dlx, dly, dlz] = dibujar_espiras_y_dl(nI,N,R,sz,I);

[Bx, By, Bz, Mx, My, Mz] = campoB(km, x, y, z, dlx, dly, dlz);

Lx = length(Mx);
Ly = length(My);
idx_x = ceil(Lx / 2);
idx_y = ceil(Ly / 2);
Bz_eje = squeeze(Bz(idx_x, idx_y, :));
        for k = 1:length(Mz)
           Bz_slice = squeeze(Bz(:, : , k));
        end

z_eje = Mz;

% Cálculo de la derivada
delta = 0.005;
dBz_dz = zeros(size(z_eje));

for i = 1:length(z_eje)
    Bz_fwd = interp1(z_eje, Bz_eje, z_eje(i)+delta, 'linear', 'extrap');
    Bz_bwd = interp1(z_eje, Bz_eje, z_eje(i)-delta, 'linear', 'extrap');
    dBz_dz(i) = (Bz_fwd - Bz_bwd) / (2*delta);
end

visualizar_campo(Mx, My, Mz, Bx, By, Bz);

% Parámetros del imán
r = 0.001; % resistencia 
m_masa = 0.004; % kg
momento_z = -1000; % A x m²
gamma = 0.05; % fricción N x s/m

% Condiciones iniciales
z0 = 5.0; % posición inicial
v0 = -0.2; % velocidad inicial
t_final = 5; % tiempo final
dt = 0.001;

phiB = zeros(1, length(Mz));

for k = 1:length(Mz)
    Bz_slice = squeeze(Bz(:, :, k));          
    phiB(k) = flujoB(Bz_slice, Mx, My, R2); 
end

dPhi_dz = diff(phiB) ./ diff(Mz);             
z_mid   = 0.5*(Mz(1:end-1) + Mz(2:end));     

[t, pos, vel] = trayectoria(m_masa, gamma, z0, v0, t_final, dt, z_mid, dPhi_dz, r);

[t_cLibre, pos_cLibre, ~] = trayectoria(m_masa, 0, z0, v0, t_final, dt, z_mid, dPhi_dz, r);

% Gráfica
figure(3);
plot(t, pos, 'r-', t_cLibre, pos_cLibre, 'b--', 'LineWidth', 1.5);
xlabel('tiempo (s)'); ylabel('posición z (m)');
title('Caída de un dipolo magnético a través de un solenoide');
legend('Con freno magnético', 'Caída libre'); grid on;

% Gráfica dBz_dz vs z
figure(4);
plot(z_eje, dBz_dz, 'b-', 'LineWidth', 1.5);
xlabel('Posición z (m)'); ylabel('dBz/dz (T/m)');
title('Derivada del campo magnético Bz respecto a z');
grid on;

