% filterDesign.m
% Raymond Plasse
% AET-5420
% 4/17/2024

clear; clc; close all;

%% 1st order filter design:

% E.g. #1: -6dB cut @ 0Hz
h = [1 -0.5];
G = abs(1) + abs(-0.5); % ensure unity gain
h = h/G;
freqz(h);

% E.g. #2: +6dB boost @ Nyq
b = 1; % taken from H[z]
a = [1 0.5]; % taken from H[z]
freqz(b,a);
% filter(b,a,x) % where x is signal

%% 2nd order filter design:

% E.g. #3: cut @ 6kHz
roots = [0.5 + 0.5j ; 0.5 - 0.5j]; % complex conjugates
h = poly(roots);
freqz(h);
% fvtool(h);
% zplane(h,1); % just pole-zero plot, needs values for both b & a

% E.g. #4: boost @ 9kHz
theta = (3/8) * pi; % need to determine angle in radians to find Re & Im parts
re = 0.5 * cos(theta);
im = 0.5 * sin(theta);

roots = [re + im*j ; re - im*j];
b = 1;
a = poly(roots)
freqz(b,a);
% zplane(b,a);