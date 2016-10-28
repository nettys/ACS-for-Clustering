function centroids = centerCluster(w,data,n)
    centroids = (w' * data) ./ repmat(sum(w)',1,n);    
    centroids(isnan(centroids)) = 0;
end