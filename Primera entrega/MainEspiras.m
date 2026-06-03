clear; close all; clc;

% Características de las espiras
nI = 5; % Número de espiras
N = 50; % Puntos por espira
R = 1.5; % Radio de cada espira (m)
sz = 1; % Separación entre espiras (m)
I = 300; % Corriente (A)
mo = 4*pi*1e-7; % Permeabilidad magnética del vacío
km = mo * I / (4*pi); % Constante de Biot-Savart
rw = 0.2; % Grosor efectivo del alambre

[x, y, z, dlx, dly, dlz] = dibujar_espiras_y_dl(nI,N,R,sz,I);
[Bx, By, Bz, Mx, My, Mz] = campoB(rw, km, x, y, z, dlx, dly, dlz);
visualizar_campo(Mx, My, Mz, Bx, By, Bz);

% Parámetros del imán
m_masa = 0.004; % kg
momento_z = -1000; % A x m²
gamma = 0.05; % fricción N x s/m

% Condiciones iniciales
z0 = 5.0;
v0 = 0;
t_final = 5;
dt = 0.001;

z_eval = linspace(-5.2, 5.2, 2000);
[Bz_eje, dBz_dz] = calcular_Bz_eje(z_eval, x, y, z, dlx, dly, km);
[t, pos, vel] = simular_caida(m_masa, momento_z, gamma, z0, v0, t_final, dt, z_eval, dBz_dz);
[t_cLibre, pos_cLibre, ~] = simular_caida(m_masa, 0, 0, z0, v0, t_final, dt, z_eval, dBz_dz);

% Gráfica
figure(3);
plot(t, pos, 'r-', t_cLibre, pos_cLibre, 'b--', 'LineWidth', 1.5);
xlabel('tiempo (s)'); ylabel('posición z (m)');
title('Caída de un dipolo magnético a través de un solenoide');
legend('Con freno magnético', 'Caída libre'); grid on;