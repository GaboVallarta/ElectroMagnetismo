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
r = 0.0001; % resistencia 
m_masa = 40; % kg
% momento_z = -1000; % A x m²
gamma = 0.05; % fricción N x s/m

% Condiciones iniciales
z0 = 2.5; % posición inicial
v0 = 0; % velocidad inicial
t_final = 5; % tiempo final
dt = 0.001;

ds_flujo = 0.02;
x_fl = -(R2*1.5) : ds_flujo : (R2*1.5);
y_fl = x_fl;
z_fl = -5.0 : ds_flujo : 5.0;

fprintf('Calculando Bz en malla fina para flujo...\n');
Bz_fl = zeros(length(x_fl), length(y_fl), length(z_fl));

for i = 1:length(x_fl)
    for j = 1:length(y_fl)
        for k = 1:length(z_fl)
            for l = 1:length(x)
                drx = x_fl(i) - x(l);
                dry = y_fl(j) - y(l);
                drz = z_fl(k) - z(l);
                r3  = (drx^2 + dry^2 + drz^2 + rw^2)^1.5;
                Bz_fl(i,j,k) = Bz_fl(i,j,k) + km*(dlx(l)*dry - dly(l)*drx)/r3;
            end
        end
    end
end

phiB = zeros(1, length(z_fl));
for k = 1:length(z_fl)
    phiB(k) = flujoB(squeeze(Bz_fl(:,:,k)), x_fl, y_fl, R2);
end

dPhi_dz = diff(phiB) ./ diff(z_fl);
z_mid   = 0.5*(z_fl(1:end-1) + z_fl(2:end));

figure('Name', 'Flujo magnético');
subplot(2,1,1);
plot(z_fl, phiB, 'b-', 'LineWidth', 1.5);
xlabel('z (m)'); ylabel('\Phi_B (Wb)'); title('Flujo magnético a través del aro');
grid on;
subplot(2,1,2);
plot(z_mid, dPhi_dz, 'r-', 'LineWidth', 1.5);
xlabel('z (m)'); ylabel('d\Phi_B/dz (Wb/m)'); title('Derivada del flujo');
grid on;

[t, pos, vel] = trayectoria(m_masa, gamma, z0, v0, t_final, dt, z_mid, dPhi_dz, r);

[t_cLibre, pos_cLibre, vel_cLibre] = trayectoria(m_masa, 0, z0, v0, t_final, dt, z_mid, zeros(size(dPhi_dz)), r);

figure;
plot(pos, vel, 'g-', 'LineWidth', 1.5);
xlabel('posición z (m)'); ylabel('velocidad (m/s)');
title('Velocidad vs Posición');
grid on;

F_eddy_tray = zeros(size(pos));
for ii = 1:length(pos)
    dp = interp1(z_mid, dPhi_dz, pos(ii), 'linear', 0);
    F_eddy_tray(ii) = -(dp^2 * vel(ii)) / r;
end
figure;
plot(pos, F_eddy_tray, 'b-', 'LineWidth', 1.5);
xlabel('posición z (m)'); ylabel('F_{eddy} (N)');
title('Fuerza de Eddy vs Posición');
grid on;


% Gráfica
figure(3);
plot(t, pos, 'r-', t_cLibre, pos_cLibre, 'b--', 'LineWidth', 1.5);
xlabel('tiempo (s)'); ylabel('posición z (m)');
title('Caída con corrientes de Eddy');
legend('Con freno magnético', 'Caída libre'); grid on;

figure(4);
plot(t, vel, 'g-', t_cLibre, vel_cLibre, 'b--', 'LineWidth', 1.5);
xlabel('tiempo (s)'); ylabel('velocidad (m/s)');
title('Velocidad con y sin freno magnético');
legend('Con freno magnético', 'Caída libre');
grid on;

fprintf('Velocidad final con freno: %.3f m/s\n', vel(end));
fprintf('Velocidad final caída libre: %.3f m/s\n', vel_cLibre(end));
fprintf('Tiempo con freno: %.3f s\n', t(end));