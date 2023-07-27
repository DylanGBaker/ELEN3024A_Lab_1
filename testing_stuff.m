function x = testing_stuff()
fs = 4000000;
t = 0:1/fs:0.1;
m =  4*cos(100*pi*t) + 3*sin(200*pi*t) + 3*sin(300*pi*t);
subplot(3,1,1);
plot(t,m);
u = cos(2000000*pi*t);
subplot(3,1,2);
plot(t,u);
set(gca,'XLim',[0.000001 0.0001]);

AM_signal = m.*u;
M = fftshift(fft(AM_signal)); 
n = length(AM_signal) - 1;
df = fs/n;
f = -fs/2:df:fs/2;
subplot(3,1,3);
plot(f,abs(M)/n);
set(gca,'XLim',[999000 1001000]);
end