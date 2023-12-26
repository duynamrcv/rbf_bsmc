function y = topology(u)
%TOPOLOGY 
id = u(1);
X1d = u(2:4);
psid = u(5);

if id == 1
    delta = [2;0;0];
elseif id == 2
    delta = [0;0;2];
elseif id == 3
    delta = [0;0;-2];
end

X1d_id = [  cos(psid)   -sin(psid)  0;...
            sin(psid)   cos(psid)   0;...
            0           0           1]*delta+X1d;
y = [X1d_id;psid];
end

