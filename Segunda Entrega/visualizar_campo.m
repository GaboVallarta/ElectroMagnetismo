function visualizar_campo(Mx, My, Mz, Bx, By, Bz)
    
    % Calculamos la magnitud del campo
    Bmag = sqrt(Bx.^2 + By.^2 + Bz.^2);
    
    % Tamaños del grid
    Ly = length(My);
 
    % Corte en el plano XZ (y = 0)
    centery = round(Ly / 2);
    
    Bx_xz = squeeze(Bx(:, centery, :));
    Bz_xz = squeeze(Bz(:, centery, :));
    Bxz = squeeze(Bmag(:, centery, :));
    
    figure(2)
    hold on
    
    pcolor(Mx, Mz, (Bxz').^(1/3)); 
    shading interp; 
    colormap jet; 
    colorbar

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