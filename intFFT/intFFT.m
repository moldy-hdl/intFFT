%% INT FFT 2020.06.19

function fft_output = intFFT(x)
    y = m2v(x); % matrix to vector
    n = length(y);
    B1 = [1 1; 1 -1]; B2 = [1 -1i; 1 1i]; % B1 and B2
    
    if n == 1
        fft_output = y;
    elseif n == 2
        fft_output = [y(1)+y(2); y(1)-y(2)];
    elseif mod(n,2) == 0
        y_shape = reshape(y,[],4).';
        WN = exp(-2*1i*pi/n).^(0:floor(n/4)-1);
        
        A1 = B1 * [y_shape(1,:); y_shape(3,:)]; A1_n4 = B1 * [y_shape(2,:) ; y_shape(4,:)];
        A2 = B2 * [A1(2,:); A1_n4(2,:)];
        fft_decompn = intFFT([A1(1,:); A1_n4(1,:)]);
        
%         if n == 4
%             fft_temp(1,:) = [fft_decompn(1,:)]; fft_temp(2,:) = [fft_decompn(2,:)]; 
%             fft_temp(3,:) = m2v( intFFT( intMul(WN,A2(1,:)) ) );
%             fft_temp(4,:) = m2v( intFFT( intMul(WN.^3,A2(2,:)) ) );
%         else
%             fft_temp(1,:) = [fft_decompn(1,:), fft_decompn(3,:)]; fft_temp(3,:) = [fft_decompn(2,:), fft_decompn(4,:)];
%             fft_temp(2,:) = m2v( intFFT( intMul(WN,A2(1,:)) ) );
%             fft_temp(4,:) = m2v( intFFT( intMul(WN.^3,A2(2,:)) ) );
%         end
        
        if n == 4
            fft_temp(1,:) = [fft_decompn(1,:)]; fft_temp(2,:) = [fft_decompn(2,:)]; 
            fft_temp(3,:) = m2v( intFFT( intMul(WN,A2(1,:)) ) );
            fft_temp(4,:) = m2v( intFFT( intMul(WN.^3,A2(2,:)) ) );
        else
            fft_temp(1,:) = [fft_decompn(1,:), fft_decompn(2,:)]; fft_temp(2,:) = [fft_decompn(3,:), fft_decompn(4,:)];
            fft_temp(3,:) = m2v( intFFT( intMul(WN,A2(1,:)) ) );
            fft_temp(4,:) = m2v( intFFT( intMul(WN.^3,A2(2,:)) ) );
        end
        
        fft_output = fft_temp;
    else
        error('N is not equal to 2^K');
    end
 
end

function vector_output = m2v(matrix_input)
    vector_temp = matrix_input.';
    vector_output(1,:) = (vector_temp(:)).'; % matrix to vector
end