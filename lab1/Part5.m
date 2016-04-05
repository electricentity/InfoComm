% Names: Jacob Nguyen and Michael Reeve
% Date:  04/02/2016
% Class: E156
% Lab 1: Satellite Acquisition
% Part 5

% start timer
tic

% data is in samples
load('C:\Users\Jacob\Desktop\Harvey Mudd\2015-2016 Year\2016 Spring Semester\ENGR156- Info Comm\Labs\Lab 1\TrimbleDataSet.mat')

L = 16367;
t = linspace(0,0.001,16367);

% creating the offset matrix for the desired sattelites
satellites = [12, 13];
offset = make_offset_table(satellites);
offset = offset(1:L,:);

% Change the 0s in the gold codes to be -1s
offset = changem(offset,-1,0);

g = length(satellites);

Storage = zeros(9, 4);

for n=1:9
    
    fc = 4128400 + (n-1)*500;
    % Using Quadrature Demodulation
    I = samples(1:16367)'.*cos(2*pi*fc.*t);
    Q = samples(1:16367)'.*sin(2*pi*fc.*t);

    I = I';
    Q = Q';

    I_table = zeros(2046,g);
    Q_table = I_table;
    IQ_table = Q_table;

    % calculate the autocorrelation for I and Q for each gold code (with
    % offsets)
    for k=1:g
        for i=1:2046
            I_value = sum(offset(:,(k-1)*2046+i).*I);
            Q_value = sum(offset(:,(k-1)*2046+i).*Q);
            I_table(i,k) = I_value;
            Q_table(i,k) = Q_value;
            IQ_value = sqrt(I_value.^2 + Q_value.^2);
            IQ_table(i,k) = IQ_value;
        end
    end

    % find the max for each satellite and its index (its delay)
    [max_all, index_all] = max(IQ_table);

    [max_val,index] = max(max_all);

    % print pertinent information
    satellite = satellites(index);
    delay_half_chips = index_all(index);
    delay_chips = delay_half_chips/2;
    Storage(n,:) = [satellite, max_val, delay_chips, fc];
end

[max_val, index] = max(Storage(:, 2));

satellite = Storage(index, 1)
delay = Storage(index, 3)
fc = Storage(index, 4)

% end timer
toc


