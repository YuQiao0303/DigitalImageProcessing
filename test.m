
%��ȡͼƬ
I = imread('rin.png');
I = rgb2gray(I);

% 1. ��������
%J = scaleYQ(I,1.5,1.5);
%J = scaleYQ(I,0.5,0.5);

% 2. ������ת
%  rotateYQ(I,30);
%  rotateYQ(I,160);
%  rotateYQ(I,240);
%  rotateYQ(I,300);

% 3. ����ֱ��ͼ���⻯
HistogramEqualization(I);