clear; close all; clc;

% Características de las espiras
nI = 5; % Número de espiras
N = 50; % Puntos por espira
R = 1; % Radio de cada espira (m)
R2 = 0.85; % Radio del iman
sz = 1; % Separación entre espiras (m)
I = 100; % Corriente (A)
N_vueltas = 500;
I_efectiva =  I * N_vueltas;
mo = 4*pi*1e-7; % Permeabilidad magnética del vacío
km = mo * I_efectiva / (4*pi); % Constante de Biot-Savart
rw = 0.2; % Grosor efectivo del alambre

[x, y, z, dlx, dly, dlz] = dibujar_espiras_y_dl(nI,N,R,sz,I);

[Bx, By, Bz, Mx, My, Mz] = campoB(km, x, y, z, dlx, dly, dlz);
visualizar_campo(Mx, My, Mz, Bx, By, Bz);

% Parámetros del imán
m_masa = 0.4; % kg
momento_z = -1000; % A x m²
gamma = 0.05; % fricción N x s/m

% Condiciones iniciales
z0 = 5; % posición inicial
v0 = 0; % velocidad inicial
t_final = 5; % tiempo final
dt = 0.001;

[t, pos, vel] = simular_caida(m_masa, momento_z, gamma, z0, v0, t_final, dt, z_eje, dBz_dz);

[t_cLibre, pos_cLibre, vel_cLibre] = simular_caida(m_masa, 0, 0, z0, v0, t_final, dt, z_eje, dBz_dz);

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

fprintf('Velocidad final con freno: %.3f m/s\n', vel(end));
fprintf('Velocidad final caída libre: %.3f m/s\n', vel_cLibre(end));
fprintf('Tiempo con freno: %.3f s\n', t(end));