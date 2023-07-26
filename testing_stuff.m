function x = testing_stuff()
fs = 100;
t = 0:1/fs:2;
%m =  4*cos(100*pi*t) + 3*sin(200*pi*t) + 3*sin(300*pi*t);\
m = cos(100*pi*t);
subplot(3,1,1);
plot(t,m);
%u = cos(1000*pi*t);
%subplot(3,1,2);
%plot(t,u);

M = fft(m);
n = length(m) - 1;
for i = 1:length(m)
    frequency_value(i) = (i/n) * fs;
    magnitude_value(i) = abs(M(i));
end
%x = m.*u;
subplot(3,1,2);
plot(frequency_value - ((1/n) * fs),magnitude_value);
end