function offset_tables = make_offset_table(satellites)
% makes a table of all possible offsets for the corresponding 
% space vehivles
    
    % obtain the gold codes for the specified satellites
    codes = make_goldcodes(satellites);

    g = length(satellites);

    % set table in advance
    table = zeros(16368,2046*g);
        
    % Double for loop to go through all possible offsets (half chips)
    for k=1:g
        for i=1:2046
            table(:,(k-1)*2046+i) = circshift(codes(:,k),(i-1)*8);
        end
    end
    
    % set the output
    offset_tables = table;

end