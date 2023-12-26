function y = lref(u)
%LREF
t = u;

% circle path
xd = 5*cos(2*pi/20*t);
yd = 5*sin(2*pi/20*t);
zd = 0.5*t+2;
psid = 2*pi/20*t + pi/2;

% xd = 10*sin(t/20) + 2*cos(t/40);
% yd = 15*cos(t/15) - 5*sin(t/5) - 15;
% zd = 0.5*sin(t/2) - 1*sin(t/2)^2 + 2;
% 
% dxd = 1/2*cos(t/20) - 1/20*sin(t/40);
% dyd = -sin(t/15) - cos(t/5);
% psid = atan2(dyd,dxd);

y = [xd;yd;zd;psid];
end

