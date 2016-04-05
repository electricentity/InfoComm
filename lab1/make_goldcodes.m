function codes = make_goldcodes(satellites)
% makes an array containing the 1023-bit C/A codes
% for the specified Space Vehicles (SVs)

% 
% G1 = 1 + X^3 + X^10
% G2 = 1 + X^2 + X^3 + X^6 + X^8 + X^9 + X^10

taps = [2 6;
        3 7;
        4 8;
        5 9;
        1 9;
        2 10; 
        1 8;
        2 9;
        3 10;
        2 3;
        3 4;
        5 6;
        6 7;
        7 8;
        8 9;
        9 10;
        1 4;
        2 5;
        3 6;
        4 7;
        5 8;
        6 9;
        1 3;
        4 6;
        5 7;
        6 8;
        7 9;
        8 10;
        1 6;
        2 7;
        3 8;
        4 9;
        5 10;
        4 10;
        1 7;
        2 8;
        4 10];
    
    lfsr1 = [1 1 1 1 1 1 1 1 1 1];
    lfsr2 = [1 1 1 1 1 1 1 1 1 1];

    G1 = zeros(1023,10);
    G2 = G1;
    
    for i=1:1023
		% Save all rows for G1 and G2
		G1(i,:) = lfsr1;
        G2(i,:) = lfsr2;
		% advance LFSRs
        fb1 = xor(lfsr1(3), lfsr1(10));
        fb2 = xor(lfsr2(2), xor(lfsr2(3), xor(lfsr2(6), xor(lfsr2(8), xor(lfsr2(9), lfsr2(10))))));
        lfsr1 = [fb1 lfsr1(1:9)];
        lfsr2 = [fb2 lfsr2(1:9)];
    end
    
    % Create 1023x37 matrix of taps/spave vehicles (SV)
    G2_n = zeros(1023,37);
    SV = G2_n;
    for k=1:37
        G2_n(:,k) = xor(G2(:,taps(k,1)), G2(:,taps(k,2)));
        SV(:,k) = xor(G1(:,10),G2_n(:,k));
    end
    
    % Upsample the space vehicles by 16
    SV_upsample = zeros(16368,37);
    upsamplingFactor = 16;
    for l=1:37
        upsampled = repmat(SV(:,l)',[upsamplingFactor 1]);
        upsampled = upsampled(:);
        SV_upsample(:,l) = upsampled;
    end
    
    % Send out gold codes based on space vehicles
    g = length(satellites);
    codes = zeros(16368,g);
    for p=1:g
        codes(:,p) = SV_upsample(:,satellites(p));
    end
        
end
 
