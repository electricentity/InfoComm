function correlation_table = make_correlation_table(satellites)
    

    offset = make_offset_table(satellites);
    offset = offset(1:16367,:);
    
    g = size(satellites);
    g = g(2);
    
    offset = changem(offset,-1,0);

    
    % variable name is data1
    load('C:\Users\Jacob\Desktop\Harvey Mudd\2015-2016 Year\2016 Spring Semester\ENGR156- Info Comm\Labs\Lab 1\data1.mat')
    % Print data1 by uncommenting below
    % data1
    data = data1';
    
    data = changem(data,-1,0);

    table = zeros(2046,g);
    for k=1:g
        for i=1:2046
            %correlation_value = sum(not(xor(offset(:,(k-1)*2046+i),data)) - xor(offset(:,(k-1)*2046 + i),data));
            correlation_value = sum(offset(:,(k-1)*2046+i).*data);
            table(i,k) = correlation_value;
        end
    end
    
    correlation_table = table;
    
% 
end
