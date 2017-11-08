%% 2.25

N = 60;
w0 = 2*pi/5;
n = 0:N-1;
T = 1;

x = sin(w0*n);

p = 2;

xdec = x(1:p:end);
figure(1)
subplot(2, 1, 1);
plot(x)
subplot(2, 1, 2);
plot(xdec)


X = fft(x);
XDEC  = fft(xdec);

Ndec = N/p;
Tdec = T*p;

figure(2)
subplot(2, 1, 1);
stem((2*pi/N)*[0:N-1], abs(X)); title('X');
subplot(2, 1, 2);
stem((2*pi/Ndec/Tdec)*[0:Ndec-1], abs(XDEC)); title('X_{dec}');

% a. We get aliasing as a result of decreasing the number of samples.


