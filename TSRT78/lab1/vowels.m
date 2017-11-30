clear
close all

[ao, fs] = audioread('ao.wav');


ao = ao(:, 1);
a = ao(10000:26000);
o = ao(40000:56000);

N = length(a);
N1 = floor(2*N/3);

aest = a(1:N1);
aval = a(N1 + 1:end);

oest = o(1:N1);
oval = o(N1 + 1:end);

% One period is 81 samples

% Determing appropriate model order
arordercv(aest, aval, 50);
xlabel('Model order n')
ylabel('W(n)')
arordercv(oest, oval, 50);
xlabel('Model order n')
ylabel('W(n)')

Aorder = 10;
Oorder = 12;

%% Estimating the model

N = length(a);
Nval = length(aval);

w = (1/N*(fs))*[0:N-1];

[tha P lama epsi] = sig2ar(aest, Aorder);

Ba = 1;
Aa = [1; tha]';

[tho P lamo epsi] = sig2ar(oest, Oorder);

Bo = 1;
Ao = [1; tho]';

%% Validation

% Compute A's residual
ea = filter(Aa, Ba, aval);

% Calculate the probability of it
% changing sign from one sample to the next
asignchange = sign_change_prob(ea)

% Compute covariance functions
eacorr = conv(ea, ea(end:-1:1));
figure;
plot(eacorr);
xlabel('k')
ylabel('R_{\epsilon\epsilon}(k)')
xlim([0 length(eacorr)])

% Compute O's residual
eo = filter(Ao, Bo, oval);

% Calculate the probability of it
% changing sign from one sample to the next
osignchange = sign_change_prob(eo)

% Compute covariance functions
eocorr = conv(eo, eo(end:-1:1));
figure;
plot(eocorr);
xlabel('k')
ylabel('R_{\epsilon\epsilon}(k)')
xlim([0 length(eocorr)])


%% Prediction comparison

iaest = iddata(aest, [], 1/fs);
iaval = iddata(aval, [], 1/fs);
ia = iddata(a, [], 1/fs);

ma = ar(iaest, Aorder);

figure
compare(iaval, ma, 1)

ioest = iddata(oest, [], 1/fs);
ioval = iddata(oval, [], 1/fs);

mo = ar(ioest, Oorder);
figure
compare(ioval, mo, 1)

%% Simulating the vowels

% Determine the period of the signals by 
% looking in their plots
figure;
subplot(2, 1, 1);
plot(a);
xlabel('Sample k')
ylabel('Amplitude')
xlim([2000 3000])

subplot(2, 1, 2);
plot(o);
xlabel('Sample k')
ylabel('Amplitude')
xlim([2000 3000])

% Pulse train for a
Pa = 78;
apt = zeros(1, N);
apt(1:Pa:end) = sqrt(Pa * lama);

% Prediction of a with pulse train
apred = filter(Ba, Aa, apt);

% Pulse train for o
Po = 81;
opt = zeros(1, N);
opt(1:Po:end) = sqrt(Po * lamo);

% Prediction of o with pulse train
opred = filter(Bo, Ao, opt);

%% DFT's

figure

w = (1/N*(fs))*[0:N-1];

subplot(2, 1, 1)

APRED = fft(apred);
plot(w(1:floor(N/2)), abs(APRED(1:floor(N/2))));
xlabel('Frequency [Hz]')
ylabel('Amplitude spectrum')

subplot(2, 1, 2)
A = fft(a);
plot(w(1:floor(N/2)), abs(A(1:floor(N/2)))); 
xlabel('Frequency [Hz]')
ylabel('Amplitude spectrum')

figure

subplot(2, 1, 1)

OPRED = fft(opred);
plot(w(1:floor(N/2)), abs(OPRED(1:floor(N/2))));
xlabel('Frequency [Hz]')
ylabel('Amplitude spectrum')

subplot(2, 1, 2)
O = fft(o);
plot(w(1:floor(N/2)), abs(O(1:floor(N/2)))); 
xlabel('Frequency [Hz]')
ylabel('Amplitude spectrum')

