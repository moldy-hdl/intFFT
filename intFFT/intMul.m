%% INT FFT 2020.06.17

function mul_output = intMul(a,x)
        % the lifting scheme (three steps) (8)
        c = real(a);  s = imag(a); % initized
        yr = real(x); yi = imag(x); 
        for i=1:length(x)
            if s(i) == 0
                yr(i) = yr(i) * c(i); yi(i) = yi(i) *c(i);
            else
                yr(i) = yr(i) + yi(i)*(c(i)-1)/s(i); % step1
                yi(i) = yi(i) + yr(i)*s(i); % step2
                yr(i) = yr(i) + yi(i)*(c(i)-1)/s(i); %step3
            end
        end
%         if s == 0
%             yr = yr * c; yi = yi *c;
%         else
%             yr = yr + yi.*(c-1)/s; % step1
%             yi = yi + yr.*s; % step2
%             yr = yr + yi.*(c-1)/s; %step3
%         end
        mul_output = yr + 1i.*yi;
end

