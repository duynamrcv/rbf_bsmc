function y = sg(u)
%SG
y = [];
ep = 0.05;
for i = 1:size(u,1)
    x = u(i);
    if x < -ep
        x = -1;
    elseif x > ep
        x = 1;
    else
        x = x/ep;
    end
    y = [y;x];
end
end

