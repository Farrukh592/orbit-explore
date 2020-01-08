load handel.mat
filename = 'hande.wav';
audiowrite(filename,y,Fs)
clear y Fs
[y, Fs] = audioread('handel.wav');
sound(y,Fs);