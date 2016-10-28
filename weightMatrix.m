function w = weightMatrix(ant,N,K)
    w = zeros(N,K);
    for i=1:N
        for j=1:K
            if ant.S(i) == j
                w(i,j) = 1;
            end
        end
    end
end