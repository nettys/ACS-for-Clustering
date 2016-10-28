function newAnts = localSearch(ants, N, K, percentage, p, data)
    newAnts = ants;
    n = size(ants,1);
    topIndex = topIndices(percentage,n);
    nTop = ceil(n * percentage / 100);   
    
    for t=1:nTop
        r = rand(N,1);
        i = topIndex(t);
        for j=1:N
            if r(j) < p
                newAnts(i).S(j) = randomCluster(newAnts(i).S(j), K);
            end
        end
        newAnts(i).w = weightMatrix(newAnts(i),N,K);
        nAtt = size(data,2);
        newAnts(i).m = centerCluster(newAnts(i).w, data, nAtt);
        newAnts(i).fitness = fitness(data,newAnts(i),N,nAtt,K);
        %disp(['ants: ' num2str(i) ' S: ' num2str(newAnts(i).S) ' new fitness: ' num2str(newAnts(i).fitness)]);
        
        if newAnts(i).fitness >= ants(i).fitness
            newAnts(i) = ants(i); 
            %disp(['--------------------------------------------------------------newAnts down ']);
        %else
            %disp(['--------------------------------------------------------------newAnts up ']);
        end
    end   
    
end