% Names: Jacob Nguyen and Michael Reeve
% Date:  04/02/2016
% Class: E156
% Lab 1: Satellite Acquisition
% Part 1

% satellites to check
satellites = [1 2 3];

% set up the offset table
offset = make_offset_table(satellites);
offset = offset(1:16367,:); % cut off 1 bit because the data sucks
offset = changem(offset,-1,0); % switch 0's with -1's because of nice math


% variable name is data1
load('C:\Users\Jacob\Desktop\Harvey Mudd\2015-2016 Year\2016 Spring Semester\ENGR156- Info Comm\Labs\Lab 1\data1.mat')
data = data1';

data = changem(data,-1,0); % switch 0's with -1's because of nice math

g = length(satellites);
table = zeros(2046,g);

% Check all possible 2046 delays for g satellites
for k=1:g
    for i=1:2046
        correlation_value = sum(offset(:,(k-1)*2046+i).*data);
        table(i,k) = correlation_value;
    end
end

% find the max for each satellite and its index (its delay)
[max_all,index_all] = max(table);

[max_val,index] = max(max_all);

% print pertinent information
satellite = satellites(index)
delay_half_chips = index_all(index)
delay_chips = delay_half_chips/2
