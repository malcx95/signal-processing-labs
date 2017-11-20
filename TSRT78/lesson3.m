%% 2.25

N = 60;
w0 = 2*pi/5;
n = 0:N-1;
T = 1;

x = sin(w0*n);

p = 7;

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
stem((2*pi/Ndec/Tdec)*[0:9-1], abs(XDEC)); title('X_{dec}');

% a. We don't get aliasing, the Nyquist criterion is still fullfilled
% b. We get aliasing now, since sinusoid frequency is greater than the 
%    Nyquist frequency after downsampling.
% c. We once again get aliasing, but now the leakage is also visible

%% 3.2

load('sig30');

N = length(y);

figure(1);
subplot(2, 2, 1);
plot(y); title('Original signal y');

[Y, w] = dtft(y);
subplot(2, 2, 2);
plot(w, abs(Y)); title('DTF\{y\}')

ypad = [y; zeros(N, 1)];
subplot(2, 2, 3);
plot(ypad); title('Padded signal y_{pad}');

[Ypad, wpad] = dtft(ypad);
subplot(2, 2, 4);
plot(wpad, abs(Ypad)); title('DTF\{y_{pad}\}');

% ans: 0.18 rad/s and 0.26 rad/s

%% 4.16

load('sig40');

figure(1);
subplot(3, 1, 1);
plot(s); title('Original signal s');

subplot(3, 1, 2);
plot(s1); title('s_1');

subplot(3, 1, 3);
plot(s2); title('s_2');

%figure(2);
[Blow, Alow] = cheby1(3, 0.5, 0.15, 'low');
[Bband, Aband] = butter(3, [0.4 0.6], 'bandpass');

figure(4);
SYSlow = tf(Blow, Alow);
bode(SYSlow); title('Low pass filter');

figure(5);
SYSband = tf(Bband, Aband);
bode(SYSband); title('Band pass filter');


figure(3);
slow = filter(Blow, Alow, s);
subplot(2, 1, 1);
plot(slow); title('s1 filtered out')


