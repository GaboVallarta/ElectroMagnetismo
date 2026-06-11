function [Bx, By, Bz, Mx, My, Mz] = campoB(km, x, y, z, dlx, dly, dlz)
    rango_x = 6; % Rango en X (m)
    rango_y = 6; % Rango en Y (m)
    rango_z = 5; % Rango en Z (m)

    Mx = -rango_x:0.1:rango_x;
    My = -rango_y:0.1:rango_y;
    Mz = -rango_z:0.05:rango_z;
    
    Lx = length(Mx);
    Ly = length(My);
    Lz = length(Mz);
    
    Bx = zeros(Lx, Ly, Lz);
    By = zeros(Lx, Ly, Lz);
    Bz = zeros(Lx, Ly, Lz);

    
    fprintf('  Grid: %d x %d x %d = %d puntos\n', Lx, Ly, Lz, Lx*Ly*Lz);

    for i = 1:Lx
        for j = 1:Ly
            for k = 1:Lz
                % Punto donde calculamos el campo
                P_campo = [Mx(i), My(j), Mz(k)];
                for l = 1:length(x)
                    % Vector desde punto fuente hasta punto campo
                    rx = P_campo(1) - x(l);
                    ry = P_campo(2) - y(l);
                    rz = P_campo(3) - z(l);
                    
                    % Distancia al cubo
                    r = sqrt(rx^2 + ry^2 + rz^2);
                    r3 = r^3;
                    
                    % Evitar división por cero
                    if r3 > 1e-10
                        % Biot-Savart
                        Bx(i,j,k) = Bx(i,j,k) + km * (dly(l) * rz - dlz(l) * ry) / r3;
                        By(i,j,k) = By(i,j,k) + km * (dlz(l) * rx - dlx(l) * rz) / r3;
                        Bz(i,j,k) = Bz(i,j,k) + km * (dlx(l) * ry - dly(l) * rx) / r3;
                    end
                end
            end
        end
    end
end