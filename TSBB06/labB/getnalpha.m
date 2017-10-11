function [n, alpha] = getnalpha(R)


	v = liu_crossop(R);
	c = (trace(R) - 1)/2;
	s = norm(v);

	if s == 0
		if c > 0
			n = [0 1 0];
			alpha = 0;
		else
			RI = R + eye(3, 3);
			n1 = R(:, 1);
			n2 = R(:, 2);
			n3 = R(:, 3);

			max_n = 0;
			if max(norm(n1), norm(n2)) < norm(n3)
				max_n = n3;
			elseif norm(n1) < norm(n2)
				max_n = n2;
			else
				max_n = n1;
			end
			n = max_n / norm(max_n);
			alpha = pi;
		end
	else
		n = v / s;
		alpha = atan(s/c);
	end
end

