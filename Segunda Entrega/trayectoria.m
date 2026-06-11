function [t, pos, vel] = trayectoria(m_masa, gamma, z0, v0, t_final, dt, z_mid, dPhi_dz, R_circuito)

    t   = 0:dt:t_final;
    Nt  = length(t);
    pos = zeros(1, Nt);
    vel = zeros(1, Nt);
    pos(1) = z0;
    vel(1) = v0;
    z_piso = -2.0;

    for i = 1:Nt-1
        z_i = pos(i);
        v_i = vel(i);

        k1z = v_i;
        k1v = a_total_eddy(z_i, v_i, dPhi_dz, z_mid, R_circuito, gamma, m_masa);

        k2z = v_i + 0.5*dt*k1v;
        k2v = a_total_eddy(z_i + 0.5*dt*k1z, v_i + 0.5*dt*k1v, dPhi_dz, z_mid, R_circuito, gamma, m_masa);

        k3z = v_i + 0.5*dt*k2v;
        k3v = a_total_eddy(z_i + 0.5*dt*k2z, v_i + 0.5*dt*k2v, dPhi_dz, z_mid, R_circuito, gamma, m_masa);

        k4z = v_i + dt*k3v;
        k4v = a_total_eddy(z_i + dt*k3z, v_i + dt*k3v, dPhi_dz, z_mid, R_circuito, gamma, m_masa);

        z_nuevo = z_i + (dt/6)*(k1z + 2*k2z + 2*k3z + k4z);
        v_nuevo = v_i + (dt/6)*(k1v + 2*k2v + 2*k3v + k4v);

        if z_nuevo <= z_piso
            frac = (z_piso - z_i)/(z_nuevo - z_i);
            t = [t(1:i), t(i) + frac*dt];
            pos = [pos(1:i), -2.5];
            vel = [vel(1:i), v_i + frac*(v_nuevo - v_i)];
            break
        end
        pos(i+1) = z_nuevo;
        vel(i+1) = v_nuevo;
    end
    t   = t(1:i+1);
    pos = pos(1:i+1);
    vel = vel(1:i+1);
end