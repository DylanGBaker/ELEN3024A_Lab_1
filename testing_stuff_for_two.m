function x = testing_stuff_for_two()
fs = 4000000;
index = 1;
lengthOfTime = -3:1/fs:5;

t = zeros(size(lengthOfTime));
f = zeros(size(lengthOfTime));
xt = zeros(size(lengthOfTime));
for i = -3:1/fs:5
    t(index) = i;
    if i >= 0.5
        xt(index) = exp(-(i-0.5));
    else
        xt(index) = 0;
    end
    index = index + 1;
end
Xf = fftshift(fft(xt));
n = length(Xf) - 1;
df = fs/n;
f = -fs/2:df:fs/2;
subplot(4,1,1);
plot(f, abs(Xf)/n);
set(gca,'XLim',[-10 10]);
index = 1;

Hf = zeros(size(lengthOfTime));
for i = -3:1/fs:5
    f(index) = i;
    if i >= -1.5 && i <= 1.5
        Hf(index) = cos((pi * i)/3); 
    else
        Hf(index) = 0;
    end
    index = index + 1;
end

subplot(4,1,2);
plot(f, Hf);
set(gca,'XLim',[-10 10]);

Mf = Xf .* Hf;

n = length(Mf) - 1;
df = fs/n;
f = -fs/2:df:fs/2;
subplot(4,1,3);
plot(f, abs(Mf)/n);
set(gca,'XLim',[-10 10]);

mt = ifftshift(ifft(Mf));
%plot(t,abs(mt));
ct_t = -3:1/fs:5;
ct = cos(2 * pi * 1000000 * ct_t);
ut = mt .* ct;

%n = length(ut) - 1;
%df = fs/n;
%f = -fs/2:df:fs/2;
%plot(f, abs(ut)/n);
%set(gca,'XLim',[-10 10]);
end