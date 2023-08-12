function Exercise_One_B()
%Initialising sampling freqeuncy to construct frequency domain representations
%and construct the message and carrier signals in the time domain.
fs = 10000000;
t = 0:1/fs:0.1;
message_signal = 4*cos(100*pi*t) + 3*sin(200*pi*t) + 3*sin(300*pi*t);

%Need to obtain the hilbert transform of the message signal.
hilbert_transform_message_signal = hilbert(message_signal);
carrier_signal_one = cos(2*pi*1000000*t);
carrier_signal_two = sin(2*pi*1000000*t);

%Taking the imaginary component of the hilbert transform as that is where
%matlab stores the information for the hilbert transform of the message
%signal.
modulated_signal = (message_signal .* carrier_signal_one) + (imag(hilbert_transform_message_signal) .* carrier_signal_two);
figure(1)
plot(t,modulated_signal);
title("Graph showing the modulated signal with respect to time")
xlabel("Time(s)")
ylabel("u(t)")
set(gca,'XLim',[0 0.1]);

%Using fft to get the frequency components. fftshift shifts the zero
%frequency to the centre of the array so that the spectrum can be graphed
%correctly.
M = fftshift(fft(modulated_signal)); 
n = length(modulated_signal) - 1;
df = fs/n;
f = -fs/2:df:fs/2;
figure(2)
plot(f,abs(M)/n);
title("Graph showing the frequency spectrum of the modulated signal")
xlabel("Frequency(Hz)")
ylabel("|U(f)|")
set(gca,'XLim',[999000 1001000]);
end