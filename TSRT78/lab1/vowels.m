
[ao, fs] = audioread('ao.wav');

ao = ao(:, 1);
a = ao(10000:26000);
o = ao(40000:56000);


aest = a(1:10000);
aval = a(10001:end);

oest = o(1:10000);
oval = o(10001:end);

arordercv(aest, aval, 50);
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

[tha P lama epsi] = sig2ar(aest, 9);

Ba = 1;
Aa = [1; tha]';

var = sqrt(lama);
e = randn(Nval, 1) * var;
apred = filter(Ba, Aa, e);


[tho P lamo epsi] = sig2ar(oest, 2);

Bo = 1;
Ao = [1; tho]';

var = sqrt(lamo);
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

%%
% Determine the period of the signals by looking in their plots
figure(2);
subplot(2, 1, 1);
plot(a); % One period is 78 samples
subplot(2, 1, 2);
plot(o); % One period is 81 samples

%%

w = (1/N*(fs))*[0:N-1];

% Pulse train for a
Pa = 78;
apt = zeros(1, N);
apt(1:Pa:end) = sqrt(Pa * lama);

% Prediction of a with pulse train
apred = filter(Ba, Aa, apt);
APRED = fft(apred);

figure(3);
subplot(2, 1, 1);
plot(w, abs(fft(a)));
subplot(2, 1, 2);
plot(w, abs(APRED));

% Pulse train for o
Po = 81;
opt = zeros(1, N);
opt(1:Po:end) = sqrt(Po * lamo);

% Prediction of o with pulse train
opred = filter(Bo, Ao, opt);
OPRED = fft(opred);

figure(4);
subplot(2, 1, 1);
plot(w, abs(fft(o)));
subplot(2, 1, 2);
plot(w, abs(OPRED));

%% Validation

ea = filter(Aa, Ba, aval);
eacorr = conv(ea, ea(end:-1:1));
figure(5);
plot(eacorr);

eo = filter(Ao, Bo, oval);
eocorr = conv(eo, eo(end:-1:1));
figure(6);
plot(eocorr);

%% Test with iddata

iaest = iddata(aest, [], 1/fs);
iaval = iddata(aval, [], 1/fs);
ia = iddata(a, [], 1/fs);

ma = ar(iaest, 9);
ap = predict(ma, iaval, 1);
figure(1)
plot(ap.OutputData)

figure(2)
compare(iaval, ma, 1)

ioest = iddata(oest, [], 1/fs);
ioval = iddata(oval, [], 1/fs);

% mo = ar(ioest, 9);
% op = predict(ma, ioval, 2);
% figure(1)
% plot(op.OutputData)
