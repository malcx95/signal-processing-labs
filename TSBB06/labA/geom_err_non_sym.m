function e1 = geom_err_non_sym(y, yb)

e1 = 0;
for k = 1:length(y),
	e1 = e1 + norm(vgg_get_nonhomg(y(:,k))-yb(:,k))^2;
end
e1 = sqrt(e1);
