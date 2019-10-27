function [ J] = innerBoundaryTracking( I )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   ����������������кڵİ�ɫ���ؾ��Ǳ߽磬�ѱ߽����������
%   �ü������ʾ��Щ���꣬�����򣬰��Ƕȴ�С��������ɶ���
[M, N ] = size(I);
J = zeros(M,N);
boundaryPixels = zeros(M*N,3);  % ÿ��ǰ���������Ǳ߽��������꣬��������������б��x/y������˳ʱ������
numOfBoundaryPixels = 0;
xSum = 0;
ySum = 0;
whiteSum = 0;
% �ҵ����б߽�������
for x = 1:M
    for y = 1:N
        if I(x,y) == 1  %�ǰ�ɫ��
            hasBlackNeighbor = 0;
            %˳����һ�����ĵ�
            xSum = xSum + x;
            ySum = ySum + y;
            whiteSum = whiteSum+1;
            %������������Ƿ��к�ɫ��
            for neighborX = x-1:1:x+1
                if hasBlackNeighbor == 1
                    break;
                end
                for neighborY = y-1:1:y+1
                    tempX = neighborX;
                    tempY = neighborY;
                    %��Ե����
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
                    % �ж��Ƿ��к�ɫ�ھ�
                    if I(tempX,tempY) == 0
                        hasBlackNeighbor = 1;
                        break;
                    end
                end
            end
            %����ǰ׵����к�ɫ�ھӣ�����Ϊ�Ǳ߽�
            if hasBlackNeighbor == 1
                numOfBoundaryPixels = numOfBoundaryPixels+1;
                boundaryPixels(numOfBoundaryPixels,1) = x;
                boundaryPixels(numOfBoundaryPixels,2) = y;
            end
        end
    end
end

%�����ĵ�
xCenter = xSum / whiteSum
yCenter = ySum / whiteSum
%�������ĵ�Ϊԭ�㽨��������ϵ��ÿ���㵽���ĵ�ĽǶ�theta,����boundaryPixels(i,3)
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

% ��˳ʱ�뷽������
boundaryPixels(numOfBoundaryPixels+1:end,:) = []; % ɾ��������
boundaryPixels = sortrows(boundaryPixels, 3,'descend');
% ��ʾ���

imshow(logical(I));title('ԭͼI');

figure(2),imshow(logical(J));title('˳ʱ�����߽��');
for i =1:numOfBoundaryPixels
    J(boundaryPixels(i,1),boundaryPixels(i,2)) = 1;
    figure(2),imshow(logical(J));title('˳ʱ�����߽��');
end

end

