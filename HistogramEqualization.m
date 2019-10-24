function [J] = HistogramEqualization(I)
%HistogramEqualization 设一幅大小为M×N的灰度图像I中，灰度为g的像素数为h(g) 。 请写出对图像I进行直方图均衡化，得到图像J的计算方法。
%   此处显示详细说明
[M, N ] = size(I);
J = zeros(M, N);
h = zeros(1,256);
%求直方图h 
for x = 1:M
    for y = 1:N
        %I(x,y)
        h(I(x,y)+ 1) =  h(I(x,y)+ 1)+1;
    end
end
%求累积分布r
r = zeros(256,1);
for i =1:256
    for j = 1:i
        r(i) = r(i) + h(j);
    end
end
for i =1:256
    r
end
% 直方图均衡化
for x = 1:M
    for y = 1:N
        J(x,y) = (r(I(x,y)+ 1) / M*N) * 256;
    end
end
% 显示结果
subplot(211)
imshow(uint8(I));title('原图I');
subplot(212)
imshow(uint8(J));title('均衡化后的图像J');

% imshow(uint8(I));title('原图I');
% figure(2),imshow(uint8(J));title('均衡化后的图像J');
end

