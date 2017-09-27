function H = createhomography2(A)

[hA, wA] = size(A);

A1 = A(:, 2:wA);
a0 = A(:, 1:1);
z = -inv(A1'*A1)*A1'*a0;

r = A * [1; z];

fprintf('Residual error: %d\n', sum(r .* r));

H = reshape([1; z], 3, 3);

