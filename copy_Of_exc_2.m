fs = 100;
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
%FFT to get the discrete fourier transform and shifted so that the zero frequency component is in the centre
% of the array.

Xf = fftshift(fft(xt)); 

%Loop to input values for H(f). This is to represent the function as if it
%was multiplied by a rect function to sit within the bandwidths.
length_f = length(Xf);
f = (-length_f/2:length_f/2-1)/length_f*fs;

for i = 1:size(f,2)
    if f(i) >= -1.5 && f(i) <= 1.5
        Hf(i) = cos((pi * f(i))/3);
    else
        Hf(i) = 0;
    end
end

figure(1)
plot(f,abs(Xf))
title("Xf")

figure(2)
plot(f, Hf)
title("Hf")
%H(f) is the transfer function in the frequency domain and so getting the
%FFT of x(t) will allow me to multiply the two in the frequency domain to
%get the message signal.

Mf = Xf .* Hf;
mt = ifft(fftshift(Mf)); %Getting inverse of the FFT but shifting the values back so the calculation is correct for the modulation.

%Plotting magnitude spectrum of M(f) but I have to divide by the length - 1 to get the correct magnitude values
figure(3)
stem(f, abs(Mf));
%(length(Mf) - 1)
%Plotting the phase of M(f) but limiting the freqeuncy range to show the
% first few frequencies phases due to the repetition of the phase for the
% frequncy domain representation of M(f)

ct = cos(2 * pi * 10 * t); %Setting up the carrier signal. 10Hz is used for demonstration purposes so that the signal can be seen.
ut = mt .* ct; %Performing the modulation.
figure(5)
plot(t,mt)
title("mt")
%Obtain the FFT of u(t) so that the frequency spectra can be plotted.

Uf = fftshift(fft(ut));

figure(4)
plot(f,abs(Uf));

%Testing convolution
ht = ifft(ifftshift(Hf));
m_test_conv_t = conv(xt,ht);
figure(10)
plot(t,m_test_conv_t(1:length(xt)))
title("convolve signals")