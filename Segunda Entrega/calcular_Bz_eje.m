function [Bz_axis, dBz_dz] = calcular_Bz_eje(z_points, x_seg, y_seg, z_seg, dlx, dly, km)
    Nz = length(z_points);
    Bz_axis = zeros(1, Nz);
    Nseg = length(x_seg);

    for i = 1:Nz
        P = [0, 0, z_points(i)];
        sumBz = 0;
        for l = 1:Nseg
            rx = P(1) - x_seg(l);
            ry = P(2) - y_seg(l);
            rz = P(3) - z_seg(l);
            r3 = (rx^2 + ry^2 + rz^2)^(3/2);
            if r3 > 1e-10
                sumBz = sumBz + km * (dlx(l)*ry - dly(l)*rx) / r3;
            end
        end
        Bz_axis(i) = sumBz;
    end

    delta = 0.005;
    dBz_dz = zeros(size(z_points));
    for i = 1:Nz
        Bz_fwd = interp1(z_points, Bz_axis, z_points(i)+delta, 'linear', 'extrap');
        Bz_bwd = interp1(z_points, Bz_axis, z_points(i)-delta, 'linear', 'extrap');
        dBz_dz(i) = (Bz_fwd - Bz_bwd) / (2*delta);
    end
end