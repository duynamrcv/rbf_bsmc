function y = attitude_control(u)
%ATTITUDE_CONTROL
Xa = u(1:3);
Xa_dot = u(4:6);
Xad_dot = u(7:9);
Vad_dot = u(10:12);
sa = u(13:15);

global Ix Iy Iz
global gammaa rhoa

phi = Xa(1); theta = Xa(2); psi = Xa(3);
T = [1  0           -sin(theta);...
     0  cos(phi)    sin(phi)*cos(theta);...
     0  -sin(phi)   cos(phi)*cos(theta)];
Va = T*Xa_dot;
p = Va(1); q = Va(2); r = Va(3);

f = [q*r*(Iy-Iz); p*r*(Iz-Ix); p*q*(Ix-Iy)];

Ia = diag([Ix,Iy,Iz]);

Uaeq = Ia*(-gammaa*(Xa_dot-Xad_dot)+Vad_dot)-f;
Uasw = -rhoa*sg(sa) - rhoa*sa;
y = Uaeq+Uasw;
end

