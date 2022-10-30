function y = rbf_pos(u)
%RBF
sp = u(1:3);
Xp1 = u(4:6);
Xp2 = u(7:9);

global b alpha beta n eta
global whatp whatp1 whatp2 mup1 mup2
 
h = zeros(n,1);
for i = 1:n
    h(i) = exp(-(norm(Xp1-mup1(:,i))^2+norm(Xp2-mup2(:,i))^2)/(2*b^2));
end

whatp_dot = 0*whatp;

for i = 1:n
    whatp_dot(i,:) = alpha*(h(i)*sp' - eta*norm(sp)*whatp(i,:));
end
whatp = whatp1 + whatp_dot + beta*(whatp1-whatp2);
whatp2 = whatp1;
whatp1 = whatp;

y = whatp'*h;
end

