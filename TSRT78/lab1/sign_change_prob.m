function prob = sign_change_prob(seq)

num_ch = 0;

for k = 1:length(seq)-1
    this_sign = seq(k) > 0;
    next_sign = seq(k+1) > 0;
    if this_sign ~= next_sign
        num_ch = num_ch + 1;
    end
end

prob = num_ch / length(seq);
    
