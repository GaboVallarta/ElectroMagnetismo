function a = a_total_eddy(z, v, dPhi_dz, z_mid, R_circuito, gamma, m)
    dPhi_dz_local = interp1(z_mid, dPhi_dz, z, 'linear', 0);
    fem = -dPhi_dz_local * v;
    I_ind = fem / R_circuito;
    F_eddy = I_ind * dPhi_dz_local;
    Ff = -gamma * v;
    Fg = -m * 9.81;

    a = (F_eddy + Ff + Fg) / m;
end