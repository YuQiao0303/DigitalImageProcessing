function [ J] = boundaryTracking( I )
%UNTITLED2 此处显示有关此函数的摘要
%   遍历，如果有邻域有黑的白色像素就是边界，把边界坐标存起来
%   用极坐标表示这些坐标，并排序，按角度从小到大输出成动画
[M, N ] = size(I);
J = zeros(M,N);
boundaryPixels = zeros(M*N,4);  % 每行前两个变量是边界像素坐标，第三个像素是其斜率x/y，用于顺时针排序
numOfBoundaryPixels = 0;

% 找到所有边界点的坐标
for x = 1:M
    for y = 1:N
        if I(x,y) == 1  %是白色点
            hasBlackNeighbor = 0;
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
                boundaryPixels(numOfBoundaryPixels,3) = x/y;
                boundaryPixels(numOfBoundaryPixels,4) = ((x-y)/abs(x-y))* sqrt(x^2 + y^2);
                %fprintf('[%d %d]:第%d个边界点',x,y,numOfBoundaryPixels);
            end
        end
    end
end

% 按顺时针方向排序
boundaryPixels(numOfBoundaryPixels+1:end,:) = []; % 删除多余行
boundaryPixels = sortrows(boundaryPixels, [4,3]);
% 显示结果
% subplot(121)
% imshow(logical(I));title('原图I');
% subplot(122)
imshow(logical(J));title('顺时针标出边界点');
for i =1:numOfBoundaryPixels
    J(boundaryPixels(i,1),boundaryPixels(i,2)) = 1;
%     subplot(121)
%     imshow(logical(I));title('原图I');
%     subplot(122)
    imshow(logical(J));title('顺时针标出边界点');
    %fprintf('[%d %d]:第%d个边界点\n',boundaryPixels(i,1),boundaryPixels(i,2),i);
end

end

