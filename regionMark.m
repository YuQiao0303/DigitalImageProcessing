function [J] = regionMark(I)
%UNTITLED 设有一幅二值图像（元素取值为0或1），请生成该图像的标记图像。
% （即第一个连通区域中的每一个白色像素的值都置为1，第二个连通区域中的每一个白色像素的值都置为2，依此类推。区域编号可不考虑顺序）
%   
[M, N ] = size(I);
J = zeros(M, N);
checked = zeros(M,N);
currentRegion = 0;

% 对每一个点，如果是白色1，则考察其四领域（上下左右的四个像素）中尚未被考察的点
% 用矩阵a表示一个栈，每行表示一个像素，第一列是像素的x坐标，第二列是像素的y坐标

%第一个点入栈
stack(1,1:2) = [1,1]; 
for x = 1:M
    for y = 1:N
        if checked(x,y) == 0 % 如果还没检查过这个点，就入栈
            stack = [stack; [x,y]];
        end
        while(~isempty(stack)) % 若栈非空
            currentX = stack(end,1);
            currentY = stack(end,2);
            stack(end,:) = []; % 出栈
            if checked(currentX,currentY) == 1 % 如果已经检查过这个点，就跳过
                break;
            end
            checked(currentX,currentY) = 1;%将该点标记为已检查
            if I(currentX,currentY) == 0  % 如果是黑色点（背景色），就跳过
                break;
            end
            if isempty(stack)  % 如果栈空，说明是一个新的区域
                currentRegion = currentRegion + 1;
            end
            J(x,y) = currentRegion;
            % 判断八领域像素是否已经检查过
            for neighborX = currentX-1:1:currentX+1
                for neighborY = currentY-1:1:currentY+1
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
                    % 若还没检查过，就入栈
                    if checked(tempX,tempY) == 0 
                        stack = [stack;[tempX,tempY]];
                    end
                end
            end
        end
       
    end
end
% 显示结果
subplot(211)
imshow(logical(I));title('原图I');
subplot(212)
imshow(uint8(J));title('标记后的图像J');
end

% %
% A(end,:)=[] %矩阵删掉一行
% A = [A; [currentX,currentY]]; % 矩阵加上一行
% isEmpty(A)矩阵是否为空
% %