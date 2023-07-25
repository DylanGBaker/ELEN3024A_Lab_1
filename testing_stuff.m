function x = testing_stuff()
t = 0:0.0001:0.05;
m =  4*cos(100*pi*t) + 3*sin(200*pi*t) + 3*sin(300*pi*t);
subplot(3,1,1);
plot(t,m);
u = cos(1000*pi*t);
subplot(3,1,2);
plot(t,u);

x = m.*u;
subplot(3,1,3);
plot(t,x);
end