function y = at_ref(u)
%AT_REF
t = u;
phid = sin(2*t/10)+1.5;
thetad = cos(3*t/40);
psid = pi*t/10+2;
y = [phid;thetad;psid];
end

