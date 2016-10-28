function top = topIndices(percentage, n)

    nTop = ceil(n * percentage / 100);
    indices = [];
    indices = 0;
    temp = 0;
    
    for i=1:n
        indices = [indices i];
        temp = temp+1;
        if temp == nTop
            break;
        end
    end    
    indices(1) = [];
    top = indices;
end