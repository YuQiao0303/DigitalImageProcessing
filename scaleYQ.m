function [J] = scaleYQ(I,scaleX,scaleY)
%scale :设一幅大小为M×N的灰度图像I中，现要变成（放大或缩小）为 P×Q的图像J，请写出J的生成算法（要求使用双线性插值）。
%  余乔 D201980953
% 设新图J上的点(x1,y1),对应原图上的点(x,y)
% x,y的整数部分分别为x0,y0
[M, N ] = size(I);
P = fix(M * scaleX);
Q = fix(N * scaleY);
J = zeros(P,Q);

for x1 = 1:P
    for y1 = 1:Q
        % 求原图中对应的像素坐标
        x = x1 * M / P;
        y = y1 * N  /Q;
        % 双线性插值
        x0 = fix(x);
        y0 = fix(y);
        % 边缘处理
        if x0 == 0
            x0 = 1;
        end
        if y0 == 0
            y0 = 1;
        end
        if(x0 > M -1)
            x0 = M -1;
        end
        if(y0 > N -1 )
            y0 = N -1;
        end
        %赋值
        J(x1,y1) =     uint8 ( I(x0,y0)    * (1-x+x0) *  (1-y+y0)  ...
                         + I(x0 +1,y0) * (x-x0)   *  (1-y+y0)  ...
                         + I(x0,y0+1)  * (1-x+x0) *  (y-y0)    ...
                         + I(x0+1,y0+1)* (x-x0)   *  (y-y0));
    end
end
% 显示结果
imshow(uint8(I));title('原图I');
figure(2),imshow(uint8(J));title('缩放后的图像J');
end

