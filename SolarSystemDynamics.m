function [state_dot] = SolarSystemDynamics(t, state)
%///////////////////////////////////////////////////////////
% Functionality    
%   Calculates the time derivative of the solar system dynamics
% Parameters
%   t: dummy time variable
%   state: state vector [mu_Sun, rx_Sun, ry_Sun, rz_Sun, vx_Sun, vy_Sun, vz_Sun, ...]
% Returns
%   state_dot: time derivative of the state vector
%///////////////////////////////////////////////////////////
    arguments
        t, state
    end

    N = size(state, 1) / 7; % number of bodies
    state_dot = zeros(N * 7, 1);
    
    % dmu/dt = 0
    % selector_mu = repmat([1; 0; 0; 0; 0; 0; 0], N, 1);
    % mus = 0 .* selector_mu;
    % state_dot = state_dot + mus;

    % dr/dt = v
    selector_v = repmat([0; 0; 0; 0; 1; 1; 1], N, 1);
    vels = state .* selector_v;
    vels = circshift(vels, -3, 1);
    state_dot = state_dot + vels;

    % dv/dt = a
    for body_index = 0:N-1
        acceleration = zeros(3, 1);
        
        r_self = state(2 + body_index * 7 : 4 + body_index * 7);

        for other_index = 0:N-1
            if other_index == body_index
                continue
            end
            
            r_other = state(2 + other_index * 7 : 4 + other_index * 7);
            GM_other = state(1 + other_index * 7);

            r_other_self = r_self - r_other;
            
            acceleration = acceleration - GM_other .* r_other_self / norm(r_other_self)^3;
        end

        state_dot(5 + body_index * 7 : 7 + body_index * 7) = acceleration;
    end
end