% distortionEffects.m
% Raymond Plasse
% AET-5420
% 1/22/2024

clear; clc; close all;

Fs = 48000;
Ts = 1 / Fs;
N = 48000;
t = [0 : N-1]' * Ts;

f = 4; % low-f for visualizing waveform, high-f for visualizing thd
in = sin(2 * pi * f * t);

% Lines 17 & 18 incorporate musical source, corresponds with each sound function call
[in,Fs] = audioread('AcGtr.wav');
N = length(in);

% Process all the samples of sine wave input signal to create output signal

% 1. Infinite Clipping (square wave output signal)

out = zeros(N,1);

% for n = 1:N
% 
%     x = in(n,1);
% 
%     if (x > 0)
%         y = 1; % y is 1 for positive x
%     else
%         y = -1; % y is -1 for negative x (and zero)
%     end
% 
%     out(n,1) = y;
% 
% end

%sound(out,Fs); % Sounds VERY distorted

% 2. Half-wave Rectification

% for n = 1:N
% 
%     x = in(n,1);
% 
%     if (x > 0)
%         y = x; % y is x for positive x
%     else
%         y = 0; % y is 0 for negative x
%     end
% 
%     out(n,1) = y;
% 
% end

%sound(out,Fs); % sounds reasonably distorted

% 3. Full-wave Rectification

for n = 1:N

    x = in(n,1);

    if (x > 0)
        y = x; % y is x for positive x
    else
        y = abs(x); % y is absolute value of x for negative x
    end

    out(n,1) = y;

end

%sound(out,Fs); % sounds distorted AND pitchy

% Waveform
%plot(t,in,t,out);
%legend('Input', 'Output');

% Characteristic Curve
%plot(in,in,in,out); axis([-1.1 1.1 -1.1 1.1]);

% Total Harmonic Distortion
%thd(out,Fs); % change f accordingly
