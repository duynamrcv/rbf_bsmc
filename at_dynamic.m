function y = at_dynamic(u)
%AT_DYNAMIC
Ua = u(1:3);
Xa = u(4:6);
Xa_dot = u(7:9);

global Ix Iy Iz

tau_phi = Ua(1); tau_theta = Ua(2); tau_psi = Ua(3);
phi = Xa(1); theta = Xa(2); psi = Xa(3);

T = [1  0           -sin(theta);...
     0  cos(phi)    sin(phi)*cos(theta);...
     0  -sin(phi)   cos(phi)*cos(theta)];

Va = T*Xa_dot;
p = Va(1); q = Va(2); r = Va(3);

phi_ddot = (q*r*(Iy-Iz) + tau_phi)/Ix;
theta_ddot = (p*r*(Iz-Ix) + tau_theta)/Iy;
psi_ddot = (p*q*(Ix-Iy) + tau_psi)/Iz;
y = [phi_ddot;theta_ddot;psi_ddot];
end

