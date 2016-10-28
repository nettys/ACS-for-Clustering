function sortedAnt = sortAnt(ants)

    fieldsOfAnt = fieldnames(ants);
    cellOfAnt = struct2cell(ants);
    sizeOfAnt = size(cellOfAnt);    
    
    cellOfAnt = reshape(cellOfAnt, sizeOfAnt(1), []);
    cellOfAnt = cellOfAnt';
    cellOfAnt = sortrows(cellOfAnt, 4);
    cellOfAnt = reshape(cellOfAnt', sizeOfAnt);

    % Convert to Struct
    sortedAnt = cell2struct(cellOfAnt, fieldsOfAnt, 1);

%     for id = 1:length(sortedAnt)
%         fprintf('%d\n',id)
%         disp(sortedAnt(id).fitness)
%     end
end