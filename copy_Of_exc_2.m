fs = 1000;
index = 1;
lengthOfTime = 0:1/fs:10;

%Initialising arrays.
t = zeros(size(lengthOfTime));
xt = zeros(size(lengthOfTime));

%Loop to input values for x(t). This is to represent the function as if it
%was multipled by a unit step function that started at x = 0.5.
for i = 0:1/fs:10
    t(index) = i;
    if i >= 0.5
        xt(index) = exp(-(i-0.5));
    else
        xt(index) = 0;
    end
    index = index + 1;
end

length_f = length(xt);
f = (-length_f/2:length_f/2-1)/length_f*fs;
Hf = zeros(size(f));
for i = 1:size(f,2)
    if f(i) >= -1.5 && f(i) <= 1.5
        Hf(i) = cos((pi * f(i))/3);
    end
end

Xf = fftshift(fft(xt));
Mf_spect = Xf .* Hf;
figure(10)
plot(f,abs(Mf_spect)/length(xt))
xlim([-10 10])

phase = angle(Mf_spect);
figure(30)
plot(f, phase);
title("angle bleh")
xlim([-10 10])
%Going to use convolution in the time domain as when two frequency domain
%signals are multiplied matlab does circular convolution which is most
%likely leading to the incorrect m(t) signal. Convolution is giving the
%correct signal. Start by getting the inverse fourier transform of H(f).
ht = ifft(ifftshift(Hf));
mt = conv(xt,ht);
figure(1)
plot(t,mt(1:length(xt)))
title("Graph showing the convolution between the input signal x(t) and the lowpass filter h(t)")
xlabel("Time(s)")
ylabel("m(t)")

ct = cos(2 * pi * 10 * t); %Setting up the carrier signal. 10Hz is used for demonstration purposes so that the signal can be seen.
ut = mt(1:length(xt)) .* ct;

figure(5)
plot(t,ut)
title("Graph showing the modulated signal with respect to time")
xlabel("Time(s)")
ylabel("u(t)")

Uf = fftshift(fft(ut));
figure(100)
plot(f, abs(Uf)/(length(Uf) - 1))
