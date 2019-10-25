function [ J ] = frequencyDomainFiltering( I ,d0, way,n)
%frequencyDomainFiltering 频域滤波
% I 为原图，d为低通滤波或高通滤波的阈值
% way 1 理想低通滤波，高斯低通滤波，巴特沃斯低通频域滤波，
% n: 如果使用butterworth滤波，取的参数n（如果不采用butterworth滤波，则n 不被使用

% 变换到频域
I=double(I);
F=fftshift(fft2(I));  %fft2 傅里叶变换 % fftshift Shift zero-frequency component to center of spectrum.
[M,N]=size(F);     
centerM = fix(M/2);
centerN = fix(N/2);

% 进行低通滤波操作
for x=1:M 
    for y=1:N
        d=sqrt((x-centerM)^2+(y-centerN)^2);   
        switch way
            case 1  % 理想低通滤波（ILPF）
                if d >  d0
                    h = 0;
                else
                    h = 1;
                end
            case 2  %高斯低通滤波 (GLPF)
                 h=1*exp(-d^2/(2*d0^2));
            case 3  %Butterworth低通滤波器(BLPF)
                 h = 1/(1+(d/d0)^(2*n));
                 
            case 4  % 理想高通滤波（IHPF）
                if d >  d0
                    h = 1;
                else
                    h = 0;
                end
                
            case 5  %高斯高通滤波 (GHPF)
                 h= 1 - 1*exp(-d^2/(2*d0^2));
            case 6  %Butterworth高通滤波器(BLPF)
                 h = 1 - 1/(1+(d/d0)^(2*n))  ;
        end
        F(x,y)=h*F(x,y);                   
    end
end

% 变回空域
F=ifftshift(F);      % 平移回去                      
J=uint8(real(ifft2(F)));      %傅里叶反变换
% 显示结果
end

