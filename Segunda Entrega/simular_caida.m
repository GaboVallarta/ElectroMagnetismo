function [t, pos, vel] = simular_caida(m, mz, gamma, z0, v0, t_final, dt, z_eval, dBz_dz)
    t = 0:dt:t_final;
    Nt = length(t);
    pos = zeros(1, Nt);
    vel = zeros(1, Nt);
    pos(1) = z0;
    vel(1) = v0;
    g = 9.81;
    mag = abs(mz);

    aceleracion = @(z, v) (-mag * interp1(z_eval, dBz_dz, z, 'linear', 'extrap') - gamma * v - m * g ) / m;

    for i = 1:Nt-1
        z_actual = pos(i);
        v_actual = vel(i);

        k1_z = v_actual;
        k1_v = aceleracion(z_actual, v_actual);

        k2_z = v_actual + 0.5 * dt * k1_v;
        k2_v = aceleracion(z_actual + 0.5 * dt * k1_z, v_actual + 0.5 * dt * k1_v);

        k3_z = v_actual + 0.5 * dt * k2_v;
        k3_v = aceleracion(z_actual + 0.5 * dt * k2_z, v_actual + 0.5 * dt * k2_v);
        
        k4_z = v_actual + dt * k3_v;
        k4_v = aceleracion(z_actual + dt * k3_z, v_actual + dt * k3_v);

        z_new = z_actual + (dt/6) * (k1_z + 2*k2_z + 2*k3_z + k4_z);
        v_new = v_actual + (dt/6) * (k1_v + 2*k2_v + 2*k3_v + k4_v);

        if z_new <= 0
            fraccion = (0 - z_actual) / (z_new - z_actual);
            t_exact = t(i) + fraccion * dt;
            pos_exact = 0;
            vel_exact = v_actual + fraccion * (v_new - v_actual);
            
            t = [t(1:i), t_exact];
            pos = [pos(1:i), pos_exact];
            vel = [vel(1:i), vel_exact];
            break;
        else
            pos(i+1) = z_new;
            vel(i+1) = v_new;
        end
    end
end