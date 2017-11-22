
[ao, fs] = audioread('ao.wav');

ao = ao(:, 1);
a = ao(10000:26000);
o = ao(40000:56000);

aest = a(1:10000);
aval = a(10001:end);

oest = o(1:10000);
oval = o(10001:end);

% arordercv(aest, aval, 50);
% arordercv(oest, oval, 50);

% For a-sound, order 9 should be used
% For o-sound, order 2 should be used

N = length(a);
Nval = length(aval);

w = (1/N*(fs))*[0:N-1];

% figure(1)
% 
% A = fft(a);
% plot(w, abs(A)); title('DFT of a')
% 
% figure(2)
% 
% O = fft(o);
% plot(w, abs(O)); title('DFT of o')
% 

[tha P lam epsi] = sig2ar(aest, 9);

B = 1;
A = [1; tha]';

var = sqrt(lam);
e = randn(Nval, 1) * var;
apred = filter(B, A, e);


[tho P lam epsi] = sig2ar(oest, 2);

Bo = 1;
Ao = [1; tho]';

var = sqrt(lam);
eo = randn(Nval, 1) * var;
opred = filter(Bo, Ao, eo);

figure(1)
subplot(2, 1, 1)

A = fft(a);
plot(w, abs(A)); title('DFT of a')


subplot(2, 1, 2)
w = (1/Nval*(fs))*[0:Nval-1];
APRED = fft(apred);
plot(w, abs(APRED)); title('DFT of a')

% am = ar(aest, 9);
% om = ar(oest, 2);

