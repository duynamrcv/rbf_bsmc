clc;
clear;
close all;

%% Prepare data
ref_file = load('ref.mat');
dis_file = load('dis.mat');
pos_1_file = load('pos_1.mat');
est_1_file = load('est_1.mat');
pos_2_file = load('pos_2.mat');
est_2_file = load('est_2.mat');
pos_3_file = load('pos_3.mat');
est_3_file = load('est_3.mat');

pos_4_file = load('pos_4.mat');
pos_5_file = load('pos_5.mat');
pos_6_file = load('pos_6.mat');

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

%% Animation
figure();
set(gcf, 'Position', get(0, 'Screensize'));
iter = 1
for i = 1:2:size(ref,1)
    clf;
    
    %% Plot trajectory paths
    subplot(3,2,[1,3,5]);
    hold on;
    grid on;
    
    % Plot curent formation
    scatter3(ref(i,1),ref(i,2),ref(i,3),70,'b','fill','Marker','h');
    scatter3(pos1(i,1),pos1(i,2),pos1(i,3),70,'r','fill','Marker','p');
    scatter3(pos2(i,1),pos2(i,2),pos2(i,3),70,'g','fill','Marker','p');
    scatter3(pos3(i,1),pos3(i,2),pos3(i,3),70,'k','fill','Marker','p');
    
    % Plot the formation
    x = [pos1(i,:);pos2(i,:);pos3(i,:);pos1(i,:)];
    plot3(x(:,1), x(:,2), x(:,3), '-m', 'LineWidth', 1);
    
    % Plot the path
    p0=plot3(ref(1:i,1),ref(1:i,2),ref(1:i,3),'-b', 'LineWidth',2,'DisplayName','Virtual Leader');
    p1=plot3(pos1(1:i,1),pos1(1:i,2),pos1(1:i,3),'-r', 'LineWidth',2,'DisplayName','UAV1');
    p2=plot3(pos2(1:i,1),pos2(1:i,2),pos2(1:i,3),'-g', 'LineWidth',2,'DisplayName','UAV2');
    p3=plot3(pos3(1:i,1),pos3(1:i,2),pos3(1:i,3),'-k', 'LineWidth',2,'DisplayName','UAV3');
    
    legend([p0, p1, p2, p3]);
    xlabel('x [m]')
    ylabel('y [m]')
    zlabel('z [m]')
    title('Quadrotor tracked paths - RBF-BSMC');
    axis equal

    xlim([-6 6]);
    ylim([-6 6]);
    zlim([0 15]);
    view([5 10]);
    
    %% Plot disturbances
    subplot(3,2,2);
    hold on;
    grid on;
    plot(time(1:i), dis(1:i,1), '-b', 'LineWidth', 2);
    xlabel('Time [s]');
    ylabel('Value [N]');
    title('Disturbance on x-axis');
    
    subplot(3,2,4);
    hold on;
    grid on;
    plot(time(1:i), dis(1:i,2), '-b', 'LineWidth', 2);
    xlabel('Time [s]');
    ylabel('Value [N]');
    title('Disturbance on y-axis');
    
    subplot(3,2,6);
    hold on;
    grid on;
    plot(time(1:i), dis(1:i,3), '-b', 'LineWidth', 2);
    xlabel('Time [s]');
    ylabel('Value [N]');
    title('Disturbance on z-axis');
    
    drawnow;
    F(iter) = getframe(gcf);
    iter = iter + 1;
end

video = VideoWriter('result.avi','Motion JPEG AVI');
video.FrameRate = 20;  % (frames per second) this number depends on the sampling time and the number of frames you have
open(video);
writeVideo(video,F);
close(video);