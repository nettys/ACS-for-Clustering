function cluster = randomCluster(currentCluster, K)
    %currentCluster = 1;
    %K = 3;
    c = (1:K);
    c(find(c == currentCluster)) = [];
    p = ones(1,K-1) * (1/2); 
    r = rand();
    
    cluster = c(find(r<=cumsum(p),1));
end