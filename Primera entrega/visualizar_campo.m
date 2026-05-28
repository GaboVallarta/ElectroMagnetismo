function visualizar_campo(Mx, My, Mz, Bx, By, Bz)
    
    % Calculamos la magnitud del campo (como en las imágenes: Bmag)
    Bmag = sqrt(Bx.^2 + By.^2 + Bz.^2);
    
    % Tamaños del grid
    Ly = length(My);
 
    % --- Corte en el plano XZ (y = 0) ---
    centery = round(Ly / 2);
    % Tomamos el índice central del eje Y (aproximadamente y = 0) para extraer un "corte"
    % Esto nos da una sección del campo en el plano XZ, que es donde ocurre la simetría axial del solenoide.
    % squeeze elimina la dimensión de y (centrada), quedando una matriz 2D (x vs z)
    
    % Usando TUS variables (Bx, By, Bz) pero asignando a los nombres de las imágenes
    dBx = Bx;
    dBz = Bz;
    
    Bx_xz = squeeze(dBx(:, centery, :));
    Bz_xz = squeeze(dBz(:, centery, :));
    Bxz = squeeze(Bmag(:, centery, :));
    
    figure(2)
    hold on
    
    % Dibuja un mapa de colores (heatmap) con la magnitud del campo en el plano XZ
    % Transponemos Bxz' para que coincidan los ejes x y z con el gráfico
    % Se usa una raíz cúbica para "suavizar" los contrastes y resaltar zonas débiles de campo
    pcolor(Mx, Mz, (Bxz').^(1/3)); 
    shading interp; 
    colormap jet; 
    colorbar
    
    % Dibuja las líneas de flujo del campo magnético en el plano XZ
    % Usa las componentes Bx y Bz para representar la dirección del campo
    % El último argumento (3) controla la densidad de las líneas de flujo
    h1 = streamslice(Mx, Mz, Bx_xz', Bz_xz', 3);
    
    set(h1, 'Color', [0.8 1 0.9]);
    
    xlabel('x'); 
    ylabel('z');
    title('Campo magnético generado por un solenoide');
    axis equal;
    
    fprintf('\n Resultados \n');
    fprintf('Campo máximo: %.2e T\n', max(Bmag(:)));
    fprintf('Campo mínimo: %.2e T\n', min(Bmag(:)));
    
    [~, idx_Mx] = min(abs(Mx));
    [~, idx_Mz] = min(abs(Mz));
    B_centro = sqrt(Bx(idx_Mx, centery, idx_Mz)^2 + By(idx_Mx, centery, idx_Mz)^2 + Bz(idx_Mx, centery, idx_Mz)^2);
    fprintf('Campo en el centro: %.2e T\n', B_centro);
end
