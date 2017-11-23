
[vim, fs] = audioread('vimiseasier.wav');
vim = vim(:, 1);

seglength = 160;
segments = {};
models = {};
pulse_trains = {};
amplitudes = [];
periods = [];


y = [];

for seg = 0:floor(length(vim)/seglength)-1
    raw = vim(1 + seglength*seg:seglength*(seg + 1));
    data = iddata(detrend(raw), [], 1/fs);
    segments{seg + 1} = data;
    m = ar(data, 8);
    rot = roots(m.a);
    rot(abs(rot)>1) = rot(abs(rot)>1)./(abs(rot(abs(rot)>1)).^2);
    m.a = poly(rot);
    models{seg + 1} = m;
    e = filter(m.a, 1, data.OutputData);
    r = covf(e, 100);
    A = max(r(20:end));
    D = find(r == A);
    amplitudes = [amplitudes, A];
    periods = [periods, D];
    ehat = zeros(160, 1);
    ehat(1:D:end) = sqrt(A);
    pulse_trains{seg + 1} = iddata(ehat, [], 1/fs);
    yhat = filter(1, m.a, ehat);
    y = [y; yhat];
end

