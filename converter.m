function y = converter(u)
%CONVERTER
Up = u(1:3);
psid = u(4);

global g m
ux = Up(1);
uy = Up(2);
uz = Up(3);

thetad = atan((ux*cos(psid) + uy*sin(psid))/(uz+g));
phid = atan(cos(thetad)*(ux*sin(psid) - uy*cos(psid))/(uz+g));

ft = (uz + g)*m/cos(phid)/cos(thetad);
y = [ft; phid; thetad; psid];
end

