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
