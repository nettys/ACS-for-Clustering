function k = exploration(tau)

    p= zeros(1,3);
    if sum(tau) ~= 0
        p = tau ./sum(tau);
    else
        p = ones(length(tau),1)/length(tau);
    end
    
    r = rand();
    c = cumsum(p);
    k = find(r<=c,1);    
end