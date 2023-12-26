close all;

ref_file = load('results/ref.mat');
dis_file = load('results/dis.mat');
pos_1_file = load('results/pos1.mat');
est_1_file = load('results/est1.mat');
pos_2_file = load('results/pos2.mat');
est_2_file = load('results/est2.mat');
pos_3_file = load('results/pos3.mat');
est_3_file = load('results/est3.mat');

pos_4_file = load('results/pos4.mat');
pos_5_file = load('results/pos5.mat');
pos_6_file = load('results/pos6.mat');

time = ref_file.ans.Time;
ref = ref_file.ans.Data;
dis = dis_file.ans.Data;
pos1 = pos_1_file.ans.Data;
est1 = est_1_file.ans.Data;
pos2 = pos_2_file.ans.Data;
est2 = est_2_file.ans.Data;
pos3 = pos_3_file.ans.Data;
est3 = est_3_file.ans.Data;
pos4 = pos_4_file.ans.Data;
pos5 = pos_5_file.ans.Data;
pos6 = pos_6_file.ans.Data;

ref(:,3) = ref(:,3) + 3;
pos1(:,3) = pos1(:,3)+3;
pos2(:,3) = pos2(:,3)+3;
pos3(:,3) = pos3(:,3)+3;
pos4(:,3) = pos4(:,3)+3;
pos5(:,3) = pos5(:,3)+3;
pos6(:,3) = pos6(:,3)+3;

csvwrite('scen2_time.csv',time);
csvwrite('scen2_ref.csv',ref);
csvwrite('scen2_pos1.csv',pos1);
csvwrite('scen2_pos2.csv',pos2);
csvwrite('scen2_pos3.csv',pos3);
csvwrite('scen2_dis.csv',dis);
%return;
%% 3D trajectory
% RBFNN
figure();
hold on;
grid on;

p0=plot3(ref(:,1),ref(:,2),ref(:,3),'-b','LineWidth',2,'DisplayName','Virtual Leader');
p1=plot3(pos1(:,1),pos1(:,2),pos1(:,3),'-r','LineWidth',2,'DisplayName','UAV1');
p2=plot3(pos2(:,1),pos2(:,2),pos2(:,3),'-g','LineWidth',2,'DisplayName','UAV2');
p3=plot3(pos3(:,1),pos3(:,2),pos3(:,3),'-k','LineWidth',2,'DisplayName','UAV3');

len = length(ref);
num = 10;
for i=0:num
    x0 = ref(floor(len/num)*i+1,:);
    x1 = pos1(floor(len/num)*i+1,:);
    x2 = pos2(floor(len/num)*i+1,:);
    x3 = pos3(floor(len/num)*i+1,:);
    x = [x1; x2; x3; x1];
    plot3(x0(1), x0(2), x0(3), '*m','LineWidth',1);
    plot3(x(:,1), x(:,2), x(:,3), '-hm','LineWidth',1,'MarkerFaceColor','m');
end

legend([p0, p1, p2, p3], 'Location', 'best');
xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')
title('Quadrotor tracked paths - RBF-BSMC');
axis equal

% BSMC
figure();
hold on;
grid on;

p0=plot3(ref(:,1),ref(:,2),ref(:,3),'-b','LineWidth',2,'DisplayName','Virtual Leader');
p1=plot3(pos4(:,1),pos4(:,2),pos4(:,3),'-r','LineWidth',2,'DisplayName','UAV1');
p2=plot3(pos5(:,1),pos5(:,2),pos5(:,3),'-g','LineWidth',2,'DisplayName','UAV2');
p3=plot3(pos6(:,1),pos6(:,2),pos6(:,3),'-k','LineWidth',2,'DisplayName','UAV3');

len = length(ref);
num = 10;
for i=0:num
    x0 = ref(floor(len/num)*i+1,:);
    x1 = pos4(floor(len/num)*i+1,:);
    x2 = pos5(floor(len/num)*i+1,:);
    x3 = pos6(floor(len/num)*i+1,:);
    x = [x1; x2; x3; x1];
    plot3(x0(1), x0(2), x0(3),'*m','LineWidth',1);
    plot3(x(:,1), x(:,2), x(:,3),'-hm','LineWidth',1,'MarkerFaceColor','m');
end

legend([p0, p1, p2, p3], 'Location', 'best');
xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')
title('Quadrotor tracked paths - BSMC');
axis equal

%% Tracking errors
delta1 = [2;0;0];
delta2 = [0;0;2];
delta3 = [0;0;-2];
psid = ref(:,4);
X1 = [  cos(psid).*delta1(1) - sin(psid).*delta1(2) + ref(:,1),...
        sin(psid).*delta1(1) + cos(psid).*delta1(2) + ref(:,2),...
        delta1(3)+ref(:,3)];
X2 = [  cos(psid).*delta2(1) - sin(psid).*delta2(2) + ref(:,1),...
        sin(psid).*delta2(1) + cos(psid).*delta2(2) + ref(:,2),...
        delta2(3)+ref(:,3)];
X3 = [  cos(psid).*delta3(1) - sin(psid).*delta3(2) + ref(:,1),...
        sin(psid).*delta3(1) + cos(psid).*delta3(2) + ref(:,2),...
        delta3(3)+ref(:,3)];
figure();
subplot(311);
hold on; grid on;
plot(time, X1(:,1)-pos1(:,1), '-r', 'LineWidth', 2,'DisplayName','x-RBF-BSMC');
plot(time, X1(:,2)-pos1(:,2), '-g', 'LineWidth', 2,'DisplayName','y-RBF-BSMC');
plot(time, X1(:,3)-pos1(:,3), '-k', 'LineWidth', 2,'DisplayName','z-RBF-BSMC');
plot(time, X1(:,1)-pos4(:,1), '--r', 'LineWidth', 2,'DisplayName','x-BSMC');
plot(time, X1(:,2)-pos4(:,2), '--g', 'LineWidth', 2,'DisplayName','y-BSMC');
plot(time, X1(:,3)-pos4(:,3), '--k', 'LineWidth', 2,'DisplayName','z-BSMC');
lgd = legend('Location', 'best');
lgd.NumColumns = 2;
xlabel('Time [s]');
ylabel('Value [m]');
title('Tracking errors - UAV 1');

subplot(312);
hold on; grid on;
plot(time, X2(:,1)-pos2(:,1), '-r', 'LineWidth', 2,'DisplayName','x-RBF-BSMC');
plot(time, X2(:,2)-pos2(:,2), '-g', 'LineWidth', 2,'DisplayName','y-RBF-BSMC');
plot(time, X2(:,3)-pos2(:,3), '-k', 'LineWidth', 2,'DisplayName','z-RBF-BSMC');
plot(time, X2(:,1)-pos5(:,1), '--r', 'LineWidth', 2,'DisplayName','x-BSMC');
plot(time, X2(:,2)-pos5(:,2), '--g', 'LineWidth', 2,'DisplayName','y-BSMC');
plot(time, X2(:,3)-pos5(:,3), '--k', 'LineWidth', 2,'DisplayName','z-BSMC');
lgd = legend('Location', 'best');
lgd.NumColumns = 2;
xlabel('Time [s]');
ylabel('Value [m]');
title('Tracking errors - UAV 2');

subplot(313);
hold on; grid on;
plot(time, X3(:,1)-pos3(:,1), '-r', 'LineWidth', 2,'DisplayName','x-RBF-BSMC');
plot(time, X3(:,2)-pos3(:,2), '-g', 'LineWidth', 2,'DisplayName','y-RBF-BSMC');
plot(time, X3(:,3)-pos3(:,3), '-k', 'LineWidth', 2,'DisplayName','z-RBF-BSMC');
plot(time, X3(:,1)-pos6(:,1), '--r', 'LineWidth', 2,'DisplayName','x-BSMC');
plot(time, X3(:,2)-pos6(:,2), '--g', 'LineWidth', 2,'DisplayName','y-BSMC');
plot(time, X3(:,3)-pos6(:,3), '--k', 'LineWidth', 2,'DisplayName','z-BSMC');
lgd = legend('Location', 'best');
lgd.NumColumns = 2;
xlabel('Time [s]');
ylabel('Value [m]');
title('Tracking error - UAV 3');

%% Disturbance estimation
figure();
subplot(311);
hold on; grid on;
plot(time, dis(:,1), '-b', 'LineWidth', 2,'DisplayName','Disturbance');
plot(time, est1(:,1), '--r', 'LineWidth', 2,'DisplayName','UAV1');
plot(time, est2(:,1), '-.g', 'LineWidth', 2,'DisplayName','UAV2');
plot(time, est3(:,1), ':k', 'LineWidth', 2,'DisplayName','UAV3');
xlabel('Time [s]');
ylabel('x-axis [N]');
legend('Location', 'best');
ylim([-5,25]);

subplot(312);
hold on; grid on;
plot(time, dis(:,2), '-b', 'LineWidth', 2,'DisplayName','Disturbance');
plot(time, est1(:,2), '--r', 'LineWidth', 2,'DisplayName','UAV1');
plot(time, est2(:,2), '-.g', 'LineWidth', 2,'DisplayName','UAV2');
plot(time, est3(:,2), ':k', 'LineWidth', 2,'DisplayName','UAV3');
xlabel('Time [s]');
ylabel('y-axis [N]');
legend('Location', 'best');
ylim([-5,25]);

subplot(313);
hold on; grid on;
plot(time, dis(:,3), '-b', 'LineWidth', 2,'DisplayName','Disturbance');
plot(time, est1(:,3), '--r', 'LineWidth', 2,'DisplayName','UAV1');
plot(time, est2(:,3), '-.g', 'LineWidth', 2,'DisplayName','UAV2');
plot(time, est3(:,3), ':k', 'LineWidth', 2,'DisplayName','UAV3');
xlabel('Time [s]');
ylabel('z-axis [N]');
legend('Location', 'best');
ylim([-5,25]);

%% External disturbance
figure();
grid on;
hold on;
plot(time, dis(:,1), '-b', 'LineWidth', 2,'DisplayName','x-axis');
plot(time, dis(:,2), '--r', 'LineWidth', 2,'DisplayName','y-axis');
plot(time, dis(:,3), ':g', 'LineWidth', 2,'DisplayName','z-axis');
xlabel('Time [s]');
ylabel('Disturbance [N]');
legend('Location', 'best');