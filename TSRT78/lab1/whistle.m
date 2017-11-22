
[x, fs] = audioread('./whistle.wav');

% keep only one audio channel
x = x(:, 1);

X = fft(x);

% figure(1)
% 
N = length(x);
% 
w = (1/N*(fs))*[0:N-1];
% subplot(2, 1, 1);
% plot(w, abs(X)); title('DFT of x')
% subplot(2, 1, 2);
% 
wnorm = (1/N)*[0:N-1];
% plot(wnorm, abs(X)); title('DTFT of x')

% Frequency of whistle = 1024 Hz
% Normalized frequency = 0.1281
% Dominant band = 0.1-0.15

Etot = sum(x.^2);
Etotfreq = sum(abs(X).^2)/N;

[B, A] = butter(5, 2*[0.1 0.15]);
[H, W] = freqz(B, A, N);

% figure(2)
% subplot(2, 1, 1);
% plot(W./pi, abs(H)); title('H(e^{i\omega})')

y = filtfilt(B, A, x);

Y = fft(y);
% subplot(2, 1, 2);
% plot(wnorm, abs(Y)); title('DFT of Y')

Edom = sum(y.^2);
Edomfreq = sum(abs(Y).^2)/N;

purity = 1 - (Edom/Etot)
purityfreq = 1 - (Edomfreq/Etotfreq);

% Purity is in both the time and freq domains
% is 0.0157

[th P lam epsi] = sig2ar(y, 2);

B = 1;
A = [1; th]';

var = sqrt(lam);
e = randn(N, 1) * var;

yapprox = filter(B, A, e);
[Happrox, Wapprox] = freqz(B, A, N);


ydiff = zeros(1, N);
ydiff(1) = e(1);
ydiff(2) = -ydiff(1)*th(1) + e(2);

for t = 3:N
    ydiff(t) = -ydiff(t - 1)*th(1) - ydiff(t - 2)*th(2) + e(t);
end

YAPPROX = fft(yapprox);

% Freq from yapprox = 0.1274
% Freq from x = 0.1281

figure(3)
subplot(2, 1, 1);
plot(wnorm, abs(X)); title('DFT of X')

subplot(2, 1, 2);
plot(wnorm, abs(YAPPROX)); title('DFT of yapprox')
% plot(Wapprox/(2*pi), abs(YAPPROX)); title('DFT of yapprox')

[z, p, k] = tf2zp(B, A);

dist = abs(abs(p(1)) - 1)

