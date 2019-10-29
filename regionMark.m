function [J] = regionMark(I)
%UNTITLED 设有一幅二值图像（元素取值为0或1），请生成该图像的标记图像。
% （即第一个连通区域中的每一个白色像素的值都置为某种颜色，第二个连通区域中的每一个白色像素的值都置为另一种颜色，依此类推。区域编号可不考虑顺序）
%   
[M, N ] = size(I);
J = zeros(M, N, 3);
checked = zeros(M,N);
currentRegion = 0;
%填色
colors = [254 67 101;252 157 154;249 205 173;200 200 169;131 175 155;138,151,123;224,208,0;229,131,8;220,87,18;182,194,154;];

% 对每一个点，如果是白色1，则考察其四领域（上下左右的四个像素）中尚未被考察的点
% 用矩阵stack表示一个栈，每行表示一个像素，第一列是像素的x坐标，第二列是像素的y坐标

%初始化栈
stack = zeros(M*N,2); 
stackSize = 0;
for x = 1:M
    for y = 1:N
        if checked(x,y) == 0 && I(x,y)==1 % 如果还没检查过这个点且是白色，就入栈
            %fprintf('顺序入栈：%d %d\n',x,y)
            stackSize = stackSize + 1;
            stack(stackSize,1) = x;
            stack(stackSize,2) = y;
            currentRegion  = currentRegion +1
        elseif checked(x,y) == 0 && I(x,y)==0 % 如果还没检查过这个点且是黑色，就标记为已检查
            checked(x,y) = 1;
            continue;
        else %已经检查过了，就跳过
            continue;
        end
        while(stackSize ~= 0) % 若栈非空
             % 出栈
            currentX = stack(stackSize,1);
            currentY = stack(stackSize,2);
            %fprintf('当前检查的像素：%d %d\n',currentX,currentY)
            stackSize = stackSize -1;
            
            %fprintf('因检查而出栈：%d %d\n',currentX,currentY)
            if checked(currentX,currentY) == 1 % 如果已经检查过这个点，就跳过
                continue;
            end
            checked(currentX,currentY) = 1;%将该点标记为已检查
            J(currentX,currentY,:) = colors(mod(currentRegion,10),:); %只设置了十种颜色，如果区域太多，就再从第一种颜色开始填色
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
                    % 若还没检查过且为白色，就入栈
                    if checked(tempX,tempY) == 0  && I(tempX,tempY) == 1
                        stackSize = stackSize+1;
                        stack(stackSize,1) = tempX;
                        stack(stackSize,2) = tempY;
                        %fprintf('作为%d %d的邻域入栈：%d %d\n',currentX,currentY,tempX,tempY);
                    elseif checked(tempX,tempY) == 0  && I(tempX,tempY) == 0 %未检查，黑色
                        checked(tempX,tempY) = 1;
                    end
                    
                end
            end
        end
       
    end
end


% 显示结果
subplot(121)
imshow(logical(I));title('原图I');
subplot(122)
imshow(uint8(J));title('标记后的图像J');
end

% %
% A(end,:)=[] %矩阵删掉一行
% A = [A; [currentX,currentY]]; % 矩阵加上一行
% isEmpty(A)矩阵是否为空
% %