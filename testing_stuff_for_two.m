function x = testing_stuff_for_two()
t1 = -1.5:0.0001:-0.5;
x1 = zeros(size(t1));

t2 = -0.5:0.0001:0.5;
x2 = ones(size(t2));

t3 = 0.5:0.0001:1.5;
x3 = zeros(size(t3));

t = [t1 t2 t3];
y = [x1 x2 x3];

m_t1 = exp(t1-0.5);
m_t2 = exp(t2-0.5);
m_t3 = exp(t3-0.5);

u_t1 = m_t1 .* x1;
u_t2 = m_t2 .* x2;
u_t3 = m_t3 .* x3;

u_t = [u_t1 u_t2 u_t3];

f1 = -1.5:0.0001:-0.5;
f2 = -0.5:0.0001:0.5;
f3 = 0.5:0.0001:1.5;

h_f1 = cos(pi*f1 / 3);
h_f2 = cos(pi*f2 / 3);
h_f3 = cos(pi*f3 / 3);

uf1 = fftshift(fft(u_t1));
uf2 = fftshift(fft(u_t2));
uf3 = fftshift(fft(u_t3));

mf1 = h_f1 .* uf1;
mf2 = h_f2 .* uf2;
mf3 = h_f3 .* uf3;

plot(f2, abs(mf2));


end