function mapped = map_points(H, x1)
	mapped = H*[x1; ones(1, size(x1, 2))];
	mapped = mapped./[mapped(3,:,:);
						mapped(3,:,:);
						mapped(3,:,:)];
end
