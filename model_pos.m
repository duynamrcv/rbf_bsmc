function y = model_pos(u)
%MODEL
U = u(1);
Xa1 = u(2:4);
Dp = u(5:7);

global m g

ft = U(1);
phi = Xa1(1); theta = Xa1(2); psi = Xa1(3);
dx = Dp(1); dy = Dp(2); dz = Dp(3);

x_ddot = (cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi))*ft/m + dx/m;
y_ddot = (cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi))*ft/m + dy/m;
z_ddot = cos(phi)*cos(theta)*ft/m - g + dz/m;

y = [x_ddot;y_ddot;z_ddot];
end

