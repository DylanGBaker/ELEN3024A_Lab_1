function x = Exercise_One_A()
fs = 10000000;
t = 0:1/fs:0.1;
modulation_index = 0.70;
normalised_message_signal =  (0.4408004937)*cos(100*pi*t) + (0.3306003703)*sin(200*pi*t) + (0.3306003703)*sin(300*pi*t);
subplot(4,1,1);
plot(t,normalised_message_signal);

carrier_signal = cos(2000000*pi*t);
subplot(4,1,2);
plot(t,carrier_signal);
set(gca,'XLim',[0 0.000002]);

modulated_signal = (1 + (modulation_index*normalised_message_signal)).*carrier_signal;
subplot(4,1,3);
plot(t,modulated_signal);
set(gca,'XLim',[0 0.1]);

M = fftshift(fft(modulated_signal)); 
n = length(modulated_signal) - 1;
df = fs/n;
f = -fs/2:df:fs/2;
subplot(4,1,4);
plot(f,abs(M)/n);
set(gca,'XLim',[999000 1001000]);
end