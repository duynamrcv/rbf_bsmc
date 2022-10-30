clc;
close all;
% Load model
% H = imread('ChrismasTerrain.tif'); % Get elevation data
% H (H < 0) = 0;
% H = H(401:500, 301:400);
% minH = min(min(H));
% maxH = max(max(H));
% nmaxH = 25;
% nminH = 0;
% H = (H-minH)/(maxH-minH)*(nmaxH-nminH)+nminH;
% MAPSIZE_X = size(H,2); % x index: columns of H
% MAPSIZE_Y = size(H,1); % y index: rows of H
% [X,Y] = meshgrid(1:MAPSIZE_X,1:MAPSIZE_Y); % Create all (x,y) points to plot
% 
% % Load current reference
ref_path = load('loop2.mat');
% lm = ref_path.lm;
ref = ref_path.ans;
% 
% figure();
% mesh(X,Y,H);                     % Plot the data
% colormap summer;                 % Default color map.
% set(gca, 'Position', [0 0 1 1]); % Fill the figure window.
% axis equal vis3d on;             % Set aspect ratio and turn off axis.
% shading interp;                  % Interpolate color across faces.
% material dull;                   % Mountains aren't shiny.
% camlight left;                   % Add a light over to the left somewhere.
% lighting gouraud;                % Use decent lighting.
% xlabel('x [m]');
% ylabel('y [m]');
% zlabel('z [m]');
% hold on
% 
% height = 10;

% Plot boundary
% ox = lm(1,:);
% oy = lm(2,:);
% oz = ones(size(ox))*max(max(H));
% plot3(ox, oy, oz, '-xk', 'LineWidth', 2);

% Plot desired reference
x_path = ref(1,:);
y_path = ref(2,:);
z_path = ref(3,:);
psi_path = ref(4,:);
% z_path = ones(size(x_path))*30;
% z_path = zeros(size(x_path));
% for i = 1:length(x_path)
%     z_map = H(round(y_path(i)),round(x_path(i)));
%     z_path(i) = z_map + height;
% end
% 
% [zheight, zlow] = envelope(z_path,16,'peak');   % Smooth data
plot3(x_path, y_path, z_path, '-b', 'LineWidth', 2);
grid on;
axis equal;
dt = 0.01;
data = [x_path; y_path; z_path; psi_path]';
traj = timeseries(double(data), 0.01*(0:length(data)-1));

save('new_loop2.mat', 'traj', '-v7.3');
