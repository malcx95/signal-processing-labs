function e1 = geom_err(y1, y2, y1b, y2b)

e1 = 0;
for k = 1:length(y1),
	e1 = e1 + norm(vgg_get_nonhomg(y2(:,k))-y2b(:,k))^2 + ...
		+ norm(vgg_get_nonhomg(y1(:,k))-y1b(:,k))^2;
end
e1 = sqrt(e1);

