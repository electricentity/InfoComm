% data = tracking_for_class;

I = data.I_P;

num_bits = length(I)/20;

dec_table = zeros(1,20);

for off=1:20
    avg_table = zeros(1,100);
    for i=20:120
        avg_table(i) = abs(sum(I(i*20+off:(i+1)*20+off)));
    end
    dec_table(off) = sum(avg_table);
end

[max_val, index] = max(dec_table');

for i=20:num_bits-1
    I_dec(i-19) = sum(I(i*20 + index : (i+1)*20 + index));
end
% figure(1)
% subplot(2,1,1)
% stem(I_dec)
% subplot(2,1,2)
% plot(I)

I_dec(I_dec>0)=1;
I_dec(I_dec<0)=0;

% figure(2)
% stem(I_dec)


lotsOfZeros = zeros(1,292);
sTLM_port = [1,-1,-1,-1,1,-1,1,1,lotsOfZeros];
sTLM = [sTLM_port, sTLM_port, sTLM_port, sTLM_port, sTLM_port];

corr_table = zeros(300, 1500);

for i=1:300
    corr_table(i,:) = circshift(sTLM, [0, (i-1)] );
end

I_search = I_dec(1:1500);

corr_values = zeros(1,300);

for i=1:300
            correlation_value = abs(sum(corr_table(i,:).*I_search));
            corr_values(i) = correlation_value;
end

[max_val, index] = max(corr_values');

subframe = zeros(5,3);
TOW = zeros(5,17);

for i=1:5
    subframe(i,:) = I_dec(index + (i-1)*300 + 49:index + (i-1)*300 + 51);
    TOW(i,:) = I_dec(index + (i-1)*300 + 30:index + (i-1)*300 + 46);
end

TOW(1,:)



