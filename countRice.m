function [numOfRiceGrains] = countRice()
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
numOfRiceGrains = 0;
I =imread('rice.png');

background =imopen(I,strel('disk',15));
I2=imsubtract(I,background);
level=graythresh(I2);
IBW=im2bw(I2,level);  

subplot(221)
imshow(uint8( I));title('原图');
subplot(222)
imshow(uint8(background));title('背景');
subplot(223)
imshow(uint8(I2));title('背景均匀后');
subplot(224)
imshow(logical(IBW));title('二值化');

% labeled是处理后的矩阵，numObjects是米粒的个数；
[labeled,numObjects]=bwlabel(IBW,8);

% 取一个空矩阵A，用来存放每个米粒占用的像素点数目；
[m,n]=size(labeled);
A=zeros(numOfRiceGrains,1);

% 该循环用来统计每个米粒的大小，例如，第 i 个米粒的大小，储存在A(i)中；

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

