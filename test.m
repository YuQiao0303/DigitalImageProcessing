clc
%读取图片
I = imread('rin.png');
I = rgb2gray(I);
I2 = imread('tiger.png');
I2 = rgb2gray(I2);
g = imhist(I2);
% 1. 缩放
J = scaleYQ(I,1.5,1.5);
%J = scaleYQ(I,0.5,0.5);

% 2. 旋转
  %J = rotateYQ(I,30);
%  J = rotateYQ(I,160);
%  J = rotateYQ(I,240);
%  J = rotateYQ(I,300);

% 3. 直方图均衡化
%  J = HistogramEqualize(I);

% 4. 直方图规定化
%J = HistogramSpecificate(I,g);

% 13. 二维离散傅里叶正反变换的公式
% 略

% 14. 频域滤波
% ILPF = frequencyDomainFiltering(I,30,1,1);
% GLPF = frequencyDomainFiltering(I,30,2,1);
% BLPF = frequencyDomainFiltering(I,30,3,2);
% IHPF = frequencyDomainFiltering(I,30,4,1);
% GHPF = frequencyDomainFiltering(I,30,5,1);
% BHPF = frequencyDomainFiltering(I,30,6,2);
% % 显示结果
% subplot(332)
% imshow(uint8(I));title('原图I');
% subplot(334)
% imshow(uint8(ILPF));title('ILPF');
% subplot(335)
% imshow(uint8(GLPF));title('GLPF');
% subplot(336)
% imshow(uint8(BLPF));title('BLPF');
% subplot(337)
% imshow(uint8(IHPF));title('IHPF');
% subplot(338)
% imshow(uint8(GHPF));title('GHPF');
% subplot(339)
% imshow(uint8(BHPF));title('BHPF');

% % M = 100;
% % N = 100;
% % d0 = 30;
% % n = 2;
% % centerM = fix(M/2);
% % centerN = fix(N/2);
% % [x,y] = meshgrid(1:M,1:N);
% % 
% % h = ones(M,N)./(1+(sqrt((x-centerM).^2+(y-centerN).^2)/d0)^(2*n));
% % mesh(x,y,h);

% 18.区域标记
% I = [
%     1 0 0 0 0; 
%     0,1,1,0,0;
%     0 1 1 0 1;
%     0 0 0 0 0;
%     0 0 0 1 0;
%     0 0 1 1 0;
%     0 0 0 0 1;
%     0 0 0 1 1;];
% I = imread('regionMark.bmp');
% J = regionMark(I);

% 19.边界跟踪
% 
% I = imread('boundaryTrack.bmp');
% %J = innerBoundaryTracking(I);
% J = outerBoundaryTracking(I);

% 动画测试
% J = zeros(50,50);
% imshow(logical(J));title('标记后的图像J');
% for x = 1:50
%     for y = 1:50
%         J(x,y) = 1;
%         imshow(logical(J));title('标记后的图像J');
%     end
% end


