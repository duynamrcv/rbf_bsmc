function y = lref(u)
%LREF
t = u;

% circle path
xd = 5*cos(2*pi/20*t);
yd = 5*sin(2*pi/20*t);
zd = 0.5*t+2;
psid = 2*pi/20*t + pi/2;

y = [xd;yd;zd;psid];
end

