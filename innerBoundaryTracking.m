function [ J] = innerBoundaryTracking( I )
%UNTITLED2 此处显示有关此函数的摘要
%   遍历，如果有邻域有黑的白色像素就是边界，把边界坐标存起来
%   用极坐标表示这些坐标，并排序，按角度从小到大输出成动画
[M, N ] = size(I);
J = zeros(M,N);
boundaryPixels = zeros(M*N,3);  % 每行前两个变量是边界像素坐标，第三个像素是其斜率x/y，用于顺时针排序
numOfBoundaryPixels = 0;
xSum = 0;
ySum = 0;
whiteSum = 0;
% 找到所有边界点的坐标
for x = 1:M
    for y = 1:N
        if I(x,y) == 1  %是白色点
            hasBlackNeighbor = 0;
            %顺便求一个中心点
            xSum = xSum + x;
            ySum = ySum + y;
            whiteSum = whiteSum+1;
            %考察其八领域是否有黑色点
            for neighborX = x-1:1:x+1
                if hasBlackNeighbor == 1
                    break;
                end
                for neighborY = y-1:1:y+1
                    tempX = neighborX;
                    tempY = neighborY;
                    %边缘处理
                    if tempX < 1
                        tempX = 1;
                    end
                    if tempY <1
                        tempY =1;
                    end
                    if tempX >M 
                        tempX = M;
                    end
                    if tempY > N
                        tempY = N;
                    end
                    % 判断是否有黑色邻居
                    if I(tempX,tempY) == 0
                        hasBlackNeighbor = 1;
                        break;
                    end
                end
            end
            %如果是白点且有黑色邻居，就认为是边界
            if hasBlackNeighbor == 1
                numOfBoundaryPixels = numOfBoundaryPixels+1;
                boundaryPixels(numOfBoundaryPixels,1) = x;
                boundaryPixels(numOfBoundaryPixels,2) = y;
            end
        end
    end
end

%求中心点
xCenter = xSum / whiteSum
yCenter = ySum / whiteSum
%求以中心点为原点建立极坐标系后，每个点到中心点的角度theta,存入boundaryPixels(i,3)
for i =1:numOfBoundaryPixels
    x = boundaryPixels(i,1);
    y = boundaryPixels(i,2);
    boundaryPixels(i,3) = atand((y-yCenter)/(x-xCenter));
    if (x-xCenter) <0
        boundaryPixels(i,3) = boundaryPixels(i,3) + 180;
    elseif (x-xCenter) >0  && ((y-yCenter)<0)
        boundaryPixels(i,3) = boundaryPixels(i,3) + 360;
    end
    
end

% 按顺时针方向排序
boundaryPixels(numOfBoundaryPixels+1:end,:) = []; % 删除多余行
boundaryPixels = sortrows(boundaryPixels, 3,'descend');
% 显示结果

imshow(logical(I));title('原图I');

figure(2),imshow(logical(J));title('顺时针标出边界点');
for i =1:numOfBoundaryPixels
    J(boundaryPixels(i,1),boundaryPixels(i,2)) = 1;
    figure(2),imshow(logical(J));title('顺时针标出边界点');
end

end

