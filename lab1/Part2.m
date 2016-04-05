% Names: Jacob Nguyen and Michael Reeve
% Date:  04/02/2016
% Class: E156
% Lab 1: Satellite Acquisition
% Part 2

% data is in data2
load('C:\Users\Jacob\Desktop\Harvey Mudd\2015-2016 Year\2016 Spring Semester\ENGR156- Info Comm\Labs\Lab 1\data2.mat')

L = length(data2);
t = linspace(0,0.001,L);
fc = 4130400;

% Using Quadrature Demodulation with known phase and frequency
I = data2.*cos(2*pi*fc.*t + pi/3);
Q = data2.*sin(2*pi*fc.*t + pi/3);

I = I';
Q = Q';

% Plotting the first 25 chips of the signal before and after demod 
figure(1)

subplot(2,1,1);
plot(t(1:400), data2(1:400));
title('Signal Before Demodulation')
xlabel('Time (s)')
ylabel('Voltage (V)')

subplot(2,1,2);
plot(t(1:400), I(1:400))
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Signal After Demodulation')

% creating the offset matrix for the desired sattelites
satellites = [7,8,9];
offset = make_offset_table(satellites);
offset = offset(1:L,:);

g = length(satellites);

% Change the 0s in the gold codes to be -1s
offset = changem(offset,-1,0);

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

%% Using I correlation
% find the max for each satellite and its index (its delay)
[max_all, index_all] = max(I_table);

[max_val,index] = max(max_all);

display('Using I Autocorrelation')
% print pertinent information
satellite = satellites(index)
delay_half_chips = index_all(index)
delay_chips = delay_half_chips/2

%% Using Power Autocorrelation
% find the max for each satellite and its index (its delay)
[max_all, index_all] = max(IQ_table);

[max_val,index] = max(max_all);

display('Using Power Autocorrelation')
% print pertinent information
satellite = satellites(index)
delay_half_chips = index_all(index)
delay_chips = delay_half_chips/2
