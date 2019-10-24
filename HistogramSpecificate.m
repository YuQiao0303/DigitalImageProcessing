function [ J ] = HistogramSpecificate( I,t )
%HistogramSpecificate 设一幅大小为M×N的灰度图像I中，灰度为g的像素数为h(g)，另给定一个直方图t(g)。
%请写出对图像I进行变换的方法，使得变换后的新图像的直方图与t相同（近似相等）。
[M, N ] = size(I);
J = zeros(M, N);
h = zeros(1,256);
%求直方图h 
for x = 1:M
    for y = 1:N
        h(I(x,y)+ 1) =  h(I(x,y)+ 1)+1;
    end
end
%求累积分布rh和rt
rh = zeros(1,256);
rt = zeros(1,256);
for i =1:256
    for j = 1:i
        rh(i) = rh(i) + h(j);
        rt(i) = rt(i) + t(j);
    end
end
%求各灰度级的像素出现的频率 frequencySrc 和 frequencyDes
frequencySrc = zeros(1,256);
frequencyDes = zeros(1,256);
for i =1:256
    frequencySrc(i) = rh(i) /rh(256);
    frequencyDes(i) = rt(i) /rt(256);
end
%找出与frequencySrc(i)最相近的frequencyDes(index)的index值
%distance 是frequencySrc(i) 与 frequencyDes(index) 的差
%map用于记录所有i对应的index值
map = zeros(1,256);
for i = 1:256
    [distance,index] = min(abs(frequencySrc(i)-frequencyDes));
    map(i) = index;
end

%按照映射map进行直方图规定化
for x = 1:M
    for y = 1:N
        J(x,y) = map(I(x,y)+1) ;
    end
end
% 显示结果
subplot(211)
imshow(uint8(I));title('原图I');
subplot(212)
imshow(uint8(J));title('规定化化后的图像J');
end

