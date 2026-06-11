function a = a_total_eddy(z, v, dPhi_dz, z_mid, R_circuito, gamma, m)
    dPhi_dz_local = interp1(z_mid, dPhi_dz, z, 'linear', 0);
    if isnan(dPhi_dz_local)
        dPhi_dz_local = 0;
    end
    F_eddy = -(dPhi_dz_local^2 * v) / R_circuito;
    Ff = -gamma * v;
    Fg = -m * 9.81;

    a = (F_eddy + Ff + Fg) / m;
end