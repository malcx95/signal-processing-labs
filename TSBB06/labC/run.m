function [] = run(s)

figure(1);plot(s);title('Original signal')
x = (-3:3)';
b0 = ones(7, 1);
b1 = x;
b2 = x.^2;

figure(2);
subplot(4, 1, 1); plot(b0, '-o'); title('Basis function')
subplot(4, 1, 2); plot(b1, '-o'); title('Basis function')
subplot(4, 1, 3); plot(b2, '-o'); title('Basis function')

a = exp(-x.^2/4);
subplot(4, 1, 4); plot(a, '-o')

f0 = b0.*a; f0 = f0(end:-1:1);
f1 = b1.*a; f1 = f1(end:-1:1);
f2 = b2.*a; f2 = f2(end:-1:1);

figure(3);
subplot(3, 1, 1);plot(f0, '-o'); title('Filter')
subplot(3, 1, 2);plot(f1, '-o'); title('Filter')
subplot(3, 1, 3);plot(f2, '-o'); title('Filter')

h0 = conv(s, f0, 'same');
h1 = conv(s, f1, 'same');
h2 = conv(s, f2, 'same');

G0 = diag(a);
B = [b0 b1 b2];
G = B'*G0*B;

%%
B*inv(G)

c = inv(G)*[h0;h1;h2];
figure(4)
subplot(3, 1, 1);plot(c(1,:)); title('Function values')
subplot(3, 1, 2);plot(c(2,:)); title('First derivative')
subplot(3, 1, 3);plot(c(3,:)); title('Halv of second derivative')

figure(5)
localsig = s(60-3:60+3);
reconsig = (B*c(:, 60))';
diffsig = localsig - reconsig;
subplot(3, 1, 1);plot(localsig);title('Localsig')
subplot(3, 1, 2);plot(reconsig);title('Reconsig')
subplot(3, 1, 3);plot(diffsig); title('diffsig')



