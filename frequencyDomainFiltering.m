function [ J ] = frequencyDomainFiltering( I ,d0, way,n)
%frequencyDomainFiltering Ƶ���˲�
% I Ϊԭͼ��dΪ��ͨ�˲����ͨ�˲�����ֵ
% way 1 �����ͨ�˲�����˹��ͨ�˲���������˹��ͨƵ���˲���
% n: ���ʹ��butterworth�˲���ȡ�Ĳ���n�����������butterworth�˲�����n ����ʹ��

% �任��Ƶ��
I=double(I);
F=fftshift(fft2(I));  %fft2 ����Ҷ�任 % fftshift Shift zero-frequency component to center of spectrum.
[M,N]=size(F);     
centerM = fix(M/2);
centerN = fix(N/2);

% ���е�ͨ�˲�����
for x=1:M 
    for y=1:N
        d=sqrt((x-centerM)^2+(y-centerN)^2);   
        switch way
            case 1  % �����ͨ�˲���ILPF��
                if d >  d0
                    h = 0;
                else
                    h = 1;
                end
            case 2  %��˹��ͨ�˲� (GLPF)
                 h=1*exp(-d^2/(2*d0^2));
            case 3  %Butterworth��ͨ�˲���(BLPF)
                 h = 1/(1+(d/d0)^(2*n));
                 
            case 4  % �����ͨ�˲���IHPF��
                if d >  d0
                    h = 1;
                else
                    h = 0;
                end
                
            case 5  %��˹��ͨ�˲� (GHPF)
                 h= 1 - 1*exp(-d^2/(2*d0^2));
            case 6  %Butterworth��ͨ�˲���(BLPF)
                 h = 1 - 1/(1+(d/d0)^(2*n))  ;
        end
        F(x,y)=h*F(x,y);                   
    end
end

% ��ؿ���
F=ifftshift(F);      % ƽ�ƻ�ȥ                      
J=uint8(real(ifft2(F)));      %����Ҷ���任
% ��ʾ���
end

