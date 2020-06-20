%% INT FFT 2020.06.17

function mul_output = intMul(a,x)
        % the lifting scheme (three steps) (8)
        c = real(a);  s = imag(a); % initized
        yr = real(x); yi = imag(x);
        
%         if c < 0
%             for i=1:length(x)
%                 if s(i) == 0
%                     yr(i) = yr(i) * c(i); yi(i) = yi(i) *c(i);
%                 else
%                     yr(i) = yr(i) + yi(i)*(c(i)-1)/s(i); % step1
%                     yi(i) = yi(i) + yr(i)*s(i); % step2
%                     yr(i) = yr(i) + yi(i)*(c(i)-1)/s(i); %step3
%                 end
%             end
%         else
%             for i=1:length(x)
%                 if s(i) == 0
%                     yr(i) = yr(i) * c(i); yi(i) = yi(i) *c(i);
%                 else
%                     yr(i) = yr(i) + yi(i)*(c(i)+1)/s(i); % step1
%                     yi(i) = yi(i) + yr(i)*(-s(i)); % step2
%                     yr(i) = yr(i) + yi(i)*(c(i)+1)/s(i); %step3
%                     yr(i) = -1 * yr(i); yi(i) = -1 * yi(i);
%                 end
%             end
%         end
 
        
        for i=1:length(a)
                if s(i) == 0
                    yr(i) = yr(i) * c(i); yi(i) = yi(i) *c(i);
                elseif c(i) < 0 % (-pi~-pi/2, pi~pi/2)
                    yr(i) = yr(i) + yi(i)*(c(i)-1)/s(i); % step1
                    yi(i) = yi(i) + yr(i)*s(i); % step2
                    yr(i) = yr(i) + yi(i)*(c(i)-1)/s(i); %step3
                else
                    yr(i) = yr(i) + yi(i)*(c(i)+1)/s(i); % step1
                    yi(i) = yi(i) + yr(i)*(-s(i)); % step2
                    yr(i) = yr(i) + yi(i)*(c(i)+1)/s(i); %step3
                    yr(i) = -1 * yr(i); yi(i) = -1 * yi(i);
                end
        end
        mul_output = yr + 1i.*yi;
end

