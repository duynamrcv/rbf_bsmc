clc;
clear;
close all;

global m g Ix Iy Iz
global Ts
global lamdap gammap rhop
global lamdaa gammaa rhoa
global b alpha beta n eta
global whatp whatp1 whatp2 mup1 mup2

Ts = 0.01;  % time step [s]

%% Quadrotor UAV parameters
m = 1.0;    % The mass of UAV [kg]
g = 9.81;   % The gravity acceleratin [m/s2]
Ix = 0.01;  % Moment of inertia about x axis [kg.m2]
Iy = 0.01;  % Moment of inertia about y axis [kg.m2]
Iz = 0.02;  % Moment of inertia about z axis [kg.m2]

%% UAV position controller
% BSMC
lamdap = 3;
gammap = 2;
rhop = 2;

%% UAV attitude controller
% BSMC
lamdaa = 5;
gammaa = 5;
rhoa = 2;

%% RBF model parameters
n = 50;
b = 10;
alpha = 0.2;
beta = 0.3;
eta = 0.2;

% Position
whatp = rand(n,3);
whatp1 = whatp;
whatp2 = whatp1;
rx = 15; ry = 15; rz = 15;
mu1x = linspace(-rx, rx, n);
mu1y = linspace(-ry, ry, n);
mu1z = linspace(-rz, rz, n);
mup1 = [mu1x; mu1y; mu1z];
mup2 = mup1;