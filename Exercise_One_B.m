function x = Exercise_One_B()
fs = 10000000;
t = 0:1/fs:0.1;
message_signal = 4*cos(100*pi*t) + 3*sin(200*pi*t) + 3*sin(300*pi*t);
%hilbert_transform_message_signal = 4*sin(100*pi*t) - 3*cos(200*pi*t) - 4*cos(100*pi*t);
hilbert_transform_message_signal = hilbert(message_signal);
carrier_signal_one = cos(2*pi*1000000*t);
carrier_signal_two = sin(2*pi*1000000*t);

modulated_signal = (message_signal .* carrier_signal_one) + (imag(hilbert_transform_message_signal) .* carrier_signal_two);
%modulated_signal = ((4*cos(100*pi*t).*cos(2*pi*1000000*t)) + (3*sin(200*pi*t).*sin(2*pi*1000000*t)) + (3*sin(300*pi*t).*sin(2*pi*1000000*t))) + ((4*sin(100*pi*t).*sin(2*pi*1000000*t)) - (3*cos(200*pi*t).*cos(2*pi*1000000*t)) - (4*cos(100*pi*t).*cos(2*pi*1000000*t)));
subplot(4,1,1);
plot(t,modulated_signal);
set(gca,'XLim',[0 0.1]);

M = fftshift(fft(modulated_signal)); 
n = length(modulated_signal) - 1;
df = fs/n;
f = -fs/2:df:fs/2;
subplot(4,1,2);
plot(f,abs(M)/n);
set(gca,'XLim',[999000 1001000]);
end