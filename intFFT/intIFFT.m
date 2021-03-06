%% INT IFFT 2020.06.21

function ifft_output = intIFFT(x)
    y = m2v(x); % matrix to vector
    n = length(y);
    B1 = [1 1; 1 -1]; B2_tran = [1 -1i; 1 1i]'; % B1 and B2_tran
    
    if n == 1
        ifft_output = y;
    elseif n == 2
        ifft_output = [(y(1)+y(2))/2; (y(1)-y(2))/2];
    elseif mod(n,2) == 0
        y_shape = reshape(y,[],4).'; % ��������
        WN = exp(2*1i*pi/n).^(0:floor(n/4)-1); % W for each step 
        
        ifft_comb = ( intIFFT([y_shape(1,:); y_shape(2,:)]) );
        
        if n == 4
            A1(1,:) = [ifft_comb(1,:)]; A1(2,:) = [ifft_comb(2,:)]; 
            A1(3,:) = m2v( intMul (WN, intIFFT(y_shape(3,:)) ) );
            A1(4,:) = m2v( intMul( WN.^3, intIFFT(y_shape(4,:)) ) );
        else
            % ifft_comb = ifft_comb.';
            ifft_comb1(1,:) = [ifft_comb(1,1:n/8) ifft_comb(2,1:n/8)]; ifft_comb1(2,:) = [ifft_comb(1,n/8+1:end) ifft_comb(2,n/8+1:end)]; % ���򣬵�����������
            ifft_comb = reshape(ifft_comb,[],2).';
            
            A1(1,:) = [ifft_comb1(1,:)]; A1(2,:) = [ifft_comb1(2,:)];
            
            if  n == 8
                A1(3,:) = m2v( intMul (WN, intIFFT(y_shape(3,:)) ) );
                A1(4,:) = m2v( intMul( WN.^3, intIFFT(y_shape(4,:)) ) );
            else
                A1tmp1 = intIFFT(y_shape(3,:));
                A1(3,:) = [A1tmp1(1,1:n/16) A1tmp1(2,1:n/16) A1tmp1(1,n/16+1:end) A1tmp1(2,n/16+1:end)]; A1(3,:) = intMul (WN, A1(3,:) );
                A1tmp2 = intIFFT(y_shape(4,:));
                A1(4,:) = [A1tmp2(1,1:n/16) A1tmp2(2,1:n/16) A1tmp2(1,n/16+1:end) A1tmp2(2,n/16+1:end)]; A1(4,:) = intMul( WN.^3, A1(4,:) );
            end
        end
        
        A2 = B2_tran * [A1(3,:); A1(4,:)] .* 1/2; % ��B2
        
        ifft_temp(1,:) = m2v( B1 * [A1(1,:); A2(1,:)] .* 1/2 ); ifft_temp(2,:) = m2v( B1 * [A1(2,:); A2(2,:)] .* 1/2 ); % ��B1
        
        ifft_output = ifft_temp;
    else
        error('N is not equal to 2^K');
    end
 
end

function vector_output = m2v(matrix_input)
    vector_temp = matrix_input.';
    vector_output(1,:) = (vector_temp(:)).'; % matrix to vector
end