function [numOfRiceGrains] = countRice()
%countRice �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
numOfRiceGrains = 0;
I =imread('rice.png');
I = rgb2gray(I);
I =  medfilt2(I,[3,3]); % ��ֵ�˲�
background =imopen(I,strel('disk',15));  %�������õ�����
I2=imsubtract(I,background);   %��ȥ�������������ղ�����ЧӦ
level=graythresh(I2);   %�������Ӧ��ֵ
IFinal=im2bw(I2,level);    %��ֵ�ָ�õ���ֵͼ��
IFinal = imopen(IFinal,strel('disk',3));  % �������ֿ�����һ�������

% labeled�Ǵ����ľ���numObjects�������ĸ�����
[labeled,numOfRiceGrains]=bwlabel(IFinal,8);

% ��ʾ���
subplot(221)
imshow(uint8( I));title('ԭͼ');
subplot(222)
imshow(uint8(background));title('����');
subplot(223)
imshow(uint8(I2));title('�������Ⱥ�');
subplot(224)
imshow(logical(IFinal));title('�������ڼ����ͼ��');
fprintf("��������Ϊ��%d\n",numOfRiceGrains);
end

