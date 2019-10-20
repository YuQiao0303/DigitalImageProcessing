function [ outputPic ] = rotateYQ( inputPic , theta ,mode)
    %UNTITLED2 此处显示有关此函数的摘要
    %   此处显示详细说明
    %计算新图大小
    [m,n]=size(inputPic)
    mNew = round(m * cos(theta) + n * sin(theta))
    nNew = round(m * sin(theta) + n * cos(theta))
    outputPic = zeros(mNew,nNew);
    %给新图中的像素点赋值
    for i = 1:mNew
        for j = 1:nNew
            % outputPic(i,j) equals the inputPic(x,y)
            % length = distance between the old pixel and [0,0] = x^2 + y^2
            [i,j]
            length = sqrt((i-m+sin(theta))^2 + j^2);
            % alpha = artan( y / x)
            alpha = atan(j/(i - m*sin(theta)) - theta);
            x = length * cos(alpha);
            y = length * sin(alpha);
            % 插值处理
            if mode == 0 % 最邻近插值
                xFinal = round(x);
                yFinal = round(y);
            end
            if xFinal <= n && xFinal > 0 && yFinal <= m && yFinal >0
                outputPic(i,j) = inputPic ( xFinal, yFinal );
            end
        end
    end
    imshow(outputPic);
end

