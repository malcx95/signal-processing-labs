function H = createhomography(A)

[hA, wA] = size(A);

A1 = A(:, 1:wA - 1);
a0 = A(:, wA:wA);
z = -inv(A1'*A1)*A1'*a0;

r = A * [z; 1];

fprintf('Residual error: %d\n', sum(r .* r));

H = reshape([z; 1], 3, 3);

