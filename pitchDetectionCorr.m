% pitchDetectionCorr.m
% Raymond Plasse
% HW3
% 11/20/2023

clear; clc;

[x,Fs] = audioread('testSignal.wav'); % initialize 'x' & 'Fs' based on the input signal

bufferSize = 2048; % initialize 'bufferSize' to be some power of 2
overlap = round(0.5 * bufferSize); % initialize 'overlap' to be a percentage of 'bufferSize' (always int)

N = length(x); % initialize 'N' to be total number of samples in input signal
numFrames = round(N / bufferSize) * 2; % initialize 'numFrames' to be total # of buffers based on overlap (always int)

pitch = zeros(numFrames,1); % initialize 'pitch' array based on 'numFrames' before looping
pitchCount = 1; % initialize 'pitchCount' index variable for looping through array

for n = 1:overlap:N % loop through all samples w/ each iteration increasing by the overlap (50% in this case)

    if((N-n) < bufferSize) % check to make sure we have a full buffer to work with, otherwise stop the loop
        break;
    end

    a = xcorr(x(n:n+bufferSize-1,1)); % calculate 'a' array of auto-correlation values for appropriate portion of signal

    for m = bufferSize+1:2*bufferSize-2 % loop through all correlation values w/ positive lags to hunt for first peak

        if(a(m,1) > a(m-1,1)) % check if current value is greater than previous neighbor
            if(a(m,1) > a(m+1,1)) % check if current value is greater than subsequent neighbor

                pitch(pitchCount,1) = (1 / (m-bufferSize)) * Fs; % determine pitch & assign to corresponding element of 'pitch' array
                break; % stop the inner loop

            end
        end
    end

    pitchCount = pitchCount + 1; % increment 'pitchCount' to keep track of elements in 'pitch'
    
end

plot(pitch); % plot 'pitch' array to see how pitch changes throughout duration of signal
