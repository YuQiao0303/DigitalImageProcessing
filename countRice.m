function [numOfRiceGrains] = countRice()
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
numOfRiceGrains = 0;
I =imread('rice.png');

background =imopen(I,strel('disk',15));
I2=imsubtract(I,background);
level=graythresh(I2);
IBW=im2bw(I2,level);  

subplot(221)
imshow(uint8( I));title('ԭͼ');
subplot(222)
imshow(uint8(background));title('����');
subplot(223)
imshow(uint8(I2));title('�������Ⱥ�');
subplot(224)
imshow(logical(IBW));title('��ֵ��');

% labeled�Ǵ����ľ���numObjects�������ĸ�����
[labeled,numObjects]=bwlabel(IBW,8);

% ȡһ���վ���A���������ÿ������ռ�õ����ص���Ŀ��
[m,n]=size(labeled);
A=zeros(numOfRiceGrains,1);

% ��ѭ������ͳ��ÿ�������Ĵ�С�����磬�� i �������Ĵ�С��������A(i)�У�

for x=1:numOfRiceGrains
    for i=1:m
        for j=1:n
            if labeled(i,j)==x
                A(x)=A(x)+1;
            end
        end
    end
end


end

