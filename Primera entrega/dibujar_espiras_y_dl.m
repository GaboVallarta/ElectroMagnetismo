function [x_total, y_total, z_total, dlx_total, dly_total, dlz_total] = dibujar_espiras_y_dl(nI, N, R, sz, I)

    % PASO 1: Validar los parámetros de entrada
    if nI <= 0 || N <= 0 || R <= 0 || sz <= 0
        error('Todos los parámetros deben ser mayores que cero.');
    end
    % PASO 2 y 4: Definir el vector de ángulo para una espira
    theta = linspace(0, 2*pi, N+1); % Ángulo de 0 a 2pi
    theta(end) = [];
    
    % Posiciones en una espira plana
    x_espira = R * cos(theta);
    y_espira = R * sin(theta);
    z_espira = zeros(size(theta));
    
    % Diferencial de línea dl (tangente a la circunferencia)
    dlx = -R * sin(theta) .* (2*pi/N);
    dly =  R * cos(theta) .* (2*pi/N);
    dlz = zeros(size(theta));
    
    %% PASO 5: Generalizar para n espiras (diferentes alturas en Z)
    num_p_total = nI * N;
    x_total = zeros(1, num_p_total);
    y_total = zeros(1, num_p_total);
    z_total = zeros(1, num_p_total);
    dlx_total = zeros(1, num_p_total);
    dly_total = zeros(1, num_p_total);
    dlz_total = zeros(1, num_p_total);
    
    i = 1;
    for k = 1:nI
        % Altura de la espira actual (centrada en 0, separadas por sz)
        z_offset = (k - (nI+1)/2) * sz;
        
        % Guardamos posiciones y dl de esta espira
        x_total(i:i+N-1) = x_espira;
        y_total(i:i+N-1) = y_espira;
        z_total(i:i+N-1) = z_offset + z_espira;
        
        dlx_total(i:i+N-1) = dlx;
        dly_total(i:i+N-1) = dly;
        dlz_total(i:i+N-1) = dlz;
        
        i = i + N;
    end
    
    %% PASO 6: Dibujar la espira y los vectores dl con quiver
    figure('Name', 'Espiras y vectores dl');
    plot3(x_total, y_total, z_total, 'b.', 'MarkerSize', 6);
    hold on;
    quiver3(x_total, y_total, z_total, dlx_total, dly_total, dlz_total, 0.3, 'r');
    xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');
    title('Espiras circulares y vectores diferencial de línea dl');
    grid on; axis equal;
    view(45, 30);
    legend('Puntos de la espira', 'dl');
    
    fprintf('Dibujo completado.\n');
    fprintf('Número de espiras: %d\n', nI);
    fprintf('Radio: %.2f m\n', R);
    fprintf('Separación: %.2f m\n', sz);
    fprintf('Corriente: %.0f A\n', I);
end
