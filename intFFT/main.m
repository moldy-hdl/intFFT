%% main function
% Integer Fast Fourier Transform

clear all; close all;

N = 64; % 2^K，2的幂次
x = randn(1,N); % 随机信号

y = intFFT(x); % intFFT
y_matlab = fft(x); % matlab

z = real( intIFFT(y) ); % intIFFT
z_matlab = ifft(y_matlab);