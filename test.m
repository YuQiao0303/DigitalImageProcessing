clc
%��ȡͼƬ
I = imread('rin.png');
I = rgb2gray(I);
I2 = imread('tiger.png');
I2 = rgb2gray(I2);
g = imhist(I2);
% 1. ��������
%J = scaleYQ(I,1.5,1.5);
%J = scaleYQ(I,0.5,0.5);

% 2. ������ת
  %J = rotateYQ(I,30);
%  J = rotateYQ(I,160);
%  J = rotateYQ(I,240);
%  J = rotateYQ(I,300);

% 3. ����ֱ��ͼ���⻯
%  J = HistogramEqualize(I);

% 4. ����ֱ��ͼ�涨��
 J = HistogramSpecificate(I,g);