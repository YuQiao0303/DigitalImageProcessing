function [numOfRiceGrains] = countRice()
%countRice 此处显示有关此函数的摘要
%   此处显示详细说明
numOfRiceGrains = 0;
I =imread('rice.png');
I = rgb2gray(I);
I =  medfilt2(I,[3,3]); % 中值滤波
background =imopen(I,strel('disk',15));  %开操作得到背景
I2=imsubtract(I,background);   %减去背景，消除光照不不均效应
level=graythresh(I2);   %获得自适应阈值
IFinal=im2bw(I2,level);    %阈值分割得到二值图像
IFinal = imopen(IFinal,strel('disk',3));  % 开操作分开连在一起的米粒

% labeled是处理后的矩阵，numObjects是米粒的个数；
[labeled,numOfRiceGrains]=bwlabel(IFinal,8);

% 显示结果
subplot(221)
imshow(uint8( I));title('原图');
subplot(222)
imshow(uint8(background));title('背景');
subplot(223)
imshow(uint8(I2));title('背景均匀后');
subplot(224)
imshow(logical(IFinal));title('最终用于计算的图像');
fprintf("米粒个数为：%d\n",numOfRiceGrains);
end

