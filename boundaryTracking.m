function [ J] = boundaryTracking( I )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   ����������������кڵİ�ɫ���ؾ��Ǳ߽磬�ѱ߽����������
%   �ü������ʾ��Щ���꣬�����򣬰��Ƕȴ�С��������ɶ���
[M, N ] = size(I);
J = zeros(M,N);
boundaryPixels = zeros(M*N,4);  % ÿ��ǰ���������Ǳ߽��������꣬��������������б��x/y������˳ʱ������
numOfBoundaryPixels = 0;

% �ҵ����б߽�������
for x = 1:M
    for y = 1:N
        if I(x,y) == 1  %�ǰ�ɫ��
            hasBlackNeighbor = 0;
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
                boundaryPixels(numOfBoundaryPixels,3) = x/y;
                boundaryPixels(numOfBoundaryPixels,4) = ((x-y)/abs(x-y))* sqrt(x^2 + y^2);
                %fprintf('[%d %d]:��%d���߽��',x,y,numOfBoundaryPixels);
            end
        end
    end
end

% ��˳ʱ�뷽������
boundaryPixels(numOfBoundaryPixels+1:end,:) = []; % ɾ��������
boundaryPixels = sortrows(boundaryPixels, [4,3]);
% ��ʾ���
% subplot(121)
% imshow(logical(I));title('ԭͼI');
% subplot(122)
imshow(logical(J));title('˳ʱ�����߽��');
for i =1:numOfBoundaryPixels
    J(boundaryPixels(i,1),boundaryPixels(i,2)) = 1;
%     subplot(121)
%     imshow(logical(I));title('ԭͼI');
%     subplot(122)
    imshow(logical(J));title('˳ʱ�����߽��');
    %fprintf('[%d %d]:��%d���߽��\n',boundaryPixels(i,1),boundaryPixels(i,2),i);
end

end

