function [J] = rotateYQ(I,A)
%rotate 设一幅大小为M×N的灰度图像I中，现要将其逆时针旋转 A度（角度制），得到图像J，请写出J的生成算法（要求使用近邻插值）。
%   设I(x,y)经旋转后对应的点为J(x1,y1)

% 求J的行列数P/Q
[M, N ] = size(I);
P = round( M * cosd(A) + N * sind(A));
Q = round( M * sind(A) + N * cosd(A));
J = zeros(P,Q);
for x1 = 1:P
    for y1 = 1:Q
        % 求J(x1,y1)在原图I中对应的像素坐标(x,y)
        len = sqrt(x1^2 + y1^2);
        theta = atand(x1 / y1);
        %x = len * sind(A + theta) - N * sind(A);
        x = len * sind(A + theta) - N * sind(A);
        y = len * cosd(A + theta);
        % 最邻近插值
        x0 = round(x);
        y0 = round(y);
         % 给J赋值
        if x0 < 1 || y0 < 1 || x0 > M || y0 > N
            J(x1,y1) = 0;
        else
            J(x1,y1) = I(x0,y0);
        end
    end
end
% 显示结果
imshow(uint8(I));title('变换前的图像');
figure(2),imshow(uint8(J));title('变换后的图像');
end

