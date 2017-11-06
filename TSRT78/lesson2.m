%% 2.3b

N = 32;
w1 = 1;

n = [0:N-1];
y = cos(w1*n);

[X, w] = dtft(y);

figure(1)
plot(w, abs(X));

%% 2.5

T = 3.9e-4;

figure(1);
subplot(3, 2, 1);
stem(u2); title('Original signal u_2');

subplot(3, 2, 2);
y = u2(1:3:length(u2));
stem(y); title('Downsampled signal y');

subplot(3, 2, 3);
[X, w] = dtft(u2, T);
plot(w, abs(X)); title('DTFT\{u_2\}'); xlabel('\omega [rad/s]');

subplot(3, 2, 4);
[Xy, wy] = dtft(y, T*3);
plot(wy, abs(Xy)); title('DTFT\{y\}'); xlabel('\omega [rad/s]');

% a. The signal and the transform of the downsampled signal
% is alot less detailed than the original signal. There are
% also more amplitude near pi in the downsampled signal.

dec = decimate(u2, 3);
[Xdec, wdec] = dtft(dec, T*3);

subplot(3, 2, 5);
stem(dec); title('Decimated signal y_{dec}');

subplot(3, 2, 6);
plot(wdec, abs(Xdec)); title('DTFT\{y_{dec}\}'); xlabel('\omega [rad/s]');

% b. We get no aliasing effects this time.

%% 2.10

% a

n = [0:15];

x0 = cos(n*2*pi/8);
x1 = cos(n*2*pi/7);

X0 = fft(x0);
X1 = fft(x1);

figure(1)

subplot(2, 2, 1);
stem(x0); title('x_0[n]');

subplot(2, 2, 2);
stem(x1); title('x_1[n]');

subplot(2, 2, 3);
stem(abs(X0)); title('X_0(i\omega)');

subplot(2, 2, 4);
stem(abs(X1)); title('X_1(i\omega)');

