
%读取图片
I = imread('rin.png');
I = rgb2gray(I);

% 1. 测试缩放
%J = scaleYQ(I,1.5,1.5);
%J = scaleYQ(I,0.5,0.5);

% 2. 测试旋转
%  rotateYQ(I,30);
%  rotateYQ(I,160);
%  rotateYQ(I,240);
%  rotateYQ(I,300);

% 3. 测试直方图均衡化
HistogramEqualization(I);