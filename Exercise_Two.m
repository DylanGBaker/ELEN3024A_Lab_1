function Exercise_Two()
fs = 400;
index = 1;
lengthOfTime = 0:1/fs:10;

%Initialising arrays.
t = zeros(size(lengthOfTime));
f = zeros(size(lengthOfTime));
xt = zeros(size(lengthOfTime));
Hf = zeros(size(lengthOfTime));

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
index = 1;

%Loop to input values for H(f). This is to represent the function as if it
%was multiplied by a rect function to sit within the bandwidths.
for i = -5:1/fs:5
    f(index) = i;
    if i <= 1.5 && i >= -1.5
        Hf(index) = cos((pi * i)/3); 
    else
        Hf(index) = 0;
    end
    index = index + 1;
end

%H(f) is the transfer function in the frequency domain and so getting the
%FFT of x(t) will allow me to multiply the two in the frequency domain to
%get the message signal.

Mf = Xf .* Hf;
mt = ifft(ifftshift(Mf)); %Getting inverse of the FFT but shifting the values back so the calculation is correct for the modulation.

%Plotting magnitude spectrum of M(f) but I have to divide by the length - 1 to get the correct magnitude values
figure(1)
plot(f, abs(Mf)/(length(Mf) - 1));

%Plotting the phase of M(f) but limiting the freqeuncy range to show the
% first few frequencies phases due to the repetition of the phase for the
% frequncy domain representation of M(f)
figure(2)
stem(f,angle(Mf));
xlim([0 0.2]);

ct = cos(2 * pi * 10 * t); %Setting up the carrier signal. 10Hz is used for demonstration purposes so that the signal can be seen.
ut = mt .* ct; %Performing the modulation.

figure(3)
plot(t,ut);

%Obtain the FFT of u(t) so that the frequency spectra can be plotted.

Uf = fftshift(fft(ut));

figure(4)
plot(f,abs(Uf)/(length(Uf) - 1));
end