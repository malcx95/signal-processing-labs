function value=h(d)
% spline function which 2D variant gives bicubic16 interpolation
A=-0.5;
if d<=1
    value=(A+2)*d^3-(A+3)*d^2+1;
elseif d<=2
    value=A*d^3-5*A*d^2+8*A*d-4*A;
else
    value=0;
end
end
