function Exercise_One_A()
%Initialising sampling freqeuncy to construct frequency domain representations
%and construct the message and carrier signals in the time domain.
fs = 20000000;
t = 0:1/fs:0.1;
modulation_index = 0.70;

%Construct the unnormalised message signal so that the max value can be
%found to normalise it.
unnormalised_message_signal = 4*cos(100*pi*t) + 3*sin(200*pi*t) + 3*sin(300*pi*t);
max_absolute_value = max(abs(unnormalised_message_signal));

%Obtain normalised message signal.
normalised_message_signal = unnormalised_message_signal/max_absolute_value;
figure(1)
plot(t,normalised_message_signal);
title("Graph showing the normalised message signal with respect to time")
xlabel("Time(s)")
ylabel("m_n(t)")

%Construct the message signal to modulate the normalised message signal.
carrier_signal = cos(2000000*pi*t);
figure(2)
plot(t,carrier_signal);
title("Graph showing the carrier signal with respect to time")
xlabel("Time(s)")
ylabel("c(t)")
set(gca,'XLim',[0 0.000002]);

%applying the formula for a DSB-FC modulation.
modulated_signal = (1 + (modulation_index*normalised_message_signal)).*carrier_signal;
figure(3)
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
figure(4)
plot(f,abs(M)/n);
title("Graph showing the magnitude spectrum of the modulated signal")
xlabel("Frequency(Hz)")
ylabel("|U(f)|")
%Limiting frequency so that the positive components can be seen properly
set(gca,'XLim',[999000 1001000]);



%Now need to get the envelope of the modulated signal m(t). Using matlab
%hilbert function. Sourced from https://uk.mathworks.com/help/signal/ug/envelope-extraction-using-the-analytic-signal.html

y = hilbert(modulated_signal);
env = abs(y);
figure(5)
plot(t,env);
title("Graph showing the envelope of the modulated signal with respect to time")
xlabel("Time(s)")
ylabel("d(t)")

%Find period. Using graphical methods. Choosing two peak values and
%subtracting the time values to get the period. The freqeuncy is then
%1/period.

%Removing DC component of about 0.7.
original_message_signal = env - 0.7;
figure(6)
plot(t,original_message_signal);
title("Envelope signal with DC component removed")
xlabel("Time(s)")
ylabel("d(t)")
end