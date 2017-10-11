
n = 2*rand(3, 1) - 1;
n = n/norm(n);
alpha = 2*pi*rand(1, 1);

R = liu_rodrigues(n, alpha);

R*n; % should be just n

% Determine n and alpha from R

[n_new, alpha_new] = getnalpha(R);

% Matrix exp

R_exp = expm(alpha*liu_crossop(n));

R_diff = R - R_exp;

% Eigenstuff

[e1 l1] = eig(R_exp);
[e2 l2] = eig(alpha*liu_crossop(n));

% Quaternions

q = [cos(alpha/2); n.*sin(alpha/2)];
norm(q);

x0 = randn(3, 1);
p = [0; x0];

x0bar1 = R*x0;

x0bar2 = liu_qmult(liu_qmult(q, p), liu_qinv(q));

liu_R_from_q(q);
R;

%% Estimation

N = 10;

x1 = 2*rand(3, N) - 1;
t = 2*rand(3, 1) - 1;
n = 2*rand(3, 1) - 1;
n = n/norm(n);
a = 2*pi*rand(1, 1);
R = liu_rodrigues(n, a);

x2 = R*x1 + t*ones(1, N);

s = 0.01;
x1n = x1 + s*rand(3, N);
x2n = x2 + s*rand(3, N);

a0 = mean(x1n, 2);
b0 = mean(x2n, 2);
A = x1n - a0*ones(1, N);
B = x2n - b0*ones(1, N);

[U S V] = svd(A*B');
Rest = V*U';

det(Rest);

test = b0 - Rest*a0;

x2e = Rest*x1n + test*ones(1, N);
err = norm(x2e - x2n, 'fro');


c0 = mean(data1, 2);
d0 = mean(data2, 2);
C = data1 - c0*ones(1, size(data1,2));
D = data2 - d0*ones(1, size(data2, 2));

[U S V] = svd(C*D');
RdataA = V*U';

det(RdataA);

tdataA = d0 - RdataA*c0;

x2e = RdataA*data1 + tdataA*ones(1, size(data1, 2));
err = norm(x2e - data2, 'fro');

[ndataA alphadataA] = getnalpha(RdataA);


e0 = mean(data1, 2);
f0 = mean(data2, 2);
E = data1 - e0*ones(1, size(data1,2));
F = data2 - f0*ones(1, size(data2, 2));

[U S V] = svd(E*F');
% RdataB = V*U';

tau = sign(det(U)*det(V));

sigma = [1 0 0; 0 1 0; 0 0 tau];

RdataB = V*sigma*U';

det(RdataB)

tdataB = f0 - RdataB*e0;

x2e = RdataB*data1 + tdataB*ones(1, size(data1, 2));
err = norm(x2e - data2, 'fro');

[ndataB alphadataB] = getnalpha(RdataB);

