clc
%读取图片
I = imread('rin.png');
I = rgb2gray(I);
I2 = imread('tiger.png');
I2 = rgb2gray(I2);
g = imhist(I2);
% 1. 测试缩放
%J = scaleYQ(I,1.5,1.5);
%J = scaleYQ(I,0.5,0.5);

% 2. 测试旋转
  %J = rotateYQ(I,30);
%  J = rotateYQ(I,160);
%  J = rotateYQ(I,240);
%  J = rotateYQ(I,300);

% 3. 测试直方图均衡化
%  J = HistogramEqualize(I);

% 4. 测试直方图规定化
 J = HistogramSpecificate(I,g);