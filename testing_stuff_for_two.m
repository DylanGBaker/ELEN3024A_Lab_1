function x = testing_stuff_for_two()
fs = 400;
index = 1;
lengthOfTime = 0:1/fs:10;

t = zeros(size(lengthOfTime));
f = zeros(size(lengthOfTime));
xt = zeros(size(lengthOfTime));
for i = 0:1/fs:10
    t(index) = i;
    if i >= 0.5
        xt(index) = exp(-(i-0.5));
    else
        xt(index) = 0;
    end
    index = index + 1;
end
Xf = fftshift(fft(xt));

index = 1;

Hf = zeros(size(lengthOfTime));
for i = -5:1/fs:5
    f(index) = i;
    if i <= 1.5 && i >= -1.5
        Hf(index) = cos((pi * i)/3); 
    else
        Hf(index) = 0;
    end
    index = index + 1;
end
subplot(4,1,1)
plot(f,abs(Xf)/(length(Xf) - 1));

subplot(4,1,2)
plot(f,Hf)
Mf = Xf .* Hf;

subplot(4,1,3)
plot(f,abs(Mf)/(length(Mf) - 1));

mt = ifft(ifftshift(Mf));
ct = cos(2 * pi * 10 * t);
ut = mt .* ct;
subplot(4,1,4)
plot(t, ut)
%n = length(ut) - 1;
%df = fs/n;
%f = -fs/2:df:fs/2;
%plot(f, abs(ut)/n);
%set(gca,'XLim',[-10 10]);
end