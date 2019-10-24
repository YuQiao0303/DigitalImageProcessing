function [J] = rotateYQ(I,A)
%rotate 设一幅大小为M×N的灰度图像I中，现要将其逆时针旋转 A度（角度制），得到图像J，请写出J的生成算法（要求使用近邻插值）。
%   设I(x,y)经旋转后对应的点为J(x1,y1)
% 求J的行列数P/Q
[M, N ] = size(I);
P = round( abs(M * cosd(A)) + abs(N * sind(A)));
Q = round( abs(M * sind(A)) +abs( N * cosd(A)));
J = zeros(P,Q);

for x1 = 1:P
    for y1 = 1:Q
        % 求J(x1,y1)在原图I中对应的像素坐标(x,y)
        % 方法三：
        x =  (x1-P*0.5) * cosd(A) +  (y1-Q*0.5)* sind(A) + M*0.5;
        y = -(x1-P*0.5) * sind(A) +  (y1-Q*0.5)* cosd(A) + N*0.5;
        
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
imshow(uint8(I));title('原图I');
figure(2),imshow(uint8(J));title('旋转后的图像J');
end

        % 方法一：(finished)
%         len = sqrt((x1-(P*0.5))^2 + (y1-Q*0.5)^2);
%         theta = atand((x1-(P*0.5)) / (y1-Q*0.5));
%         if(y1 < Q*0.5)
%             theta = theta + 180;
%         end
%         x = len * sind(theta + A) + M*0.5; 
%         y = len * cosd(theta + A) + N*0.5;


        % 方法二：
%         translation1 = [1 0 -P/2;0 1 -Q/2;0 0 1];%新图像的中心点平移到左上角的原点
%         rotate = [cos(A) -sin(A) 0;sin(A) cos(A) 0;0 0 1];%旋转angle角度
%         translation2 = [1 0 M/2;0 1 N/2;0 0 1];%从原点平移回去
%         X = translation2 * (rotate * (translation1* [y1;x1;1] ));%P(1)为x的值 P(2)为y的值
%         x = X(1);
%         y = X(2);
        