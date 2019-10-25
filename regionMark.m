function [J] = regionMark(I)
%UNTITLED ����һ����ֵͼ��Ԫ��ȡֵΪ0��1���������ɸ�ͼ��ı��ͼ��
% ������һ����ͨ�����е�ÿһ����ɫ���ص�ֵ����Ϊ1���ڶ�����ͨ�����е�ÿһ����ɫ���ص�ֵ����Ϊ2���������ơ������ſɲ�����˳��
%   
[M, N ] = size(I);
J = zeros(M, N);
checked = zeros(M,N);
currentRegion = 0;

% ��ÿһ���㣬����ǰ�ɫ1���򿼲����������������ҵ��ĸ����أ�����δ������ĵ�
% �þ���a��ʾһ��ջ��ÿ�б�ʾһ�����أ���һ�������ص�x���꣬�ڶ��������ص�y����

%��һ������ջ
stack(1,1:2) = [1,1]; 
for x = 1:M
    for y = 1:N
        if checked(x,y) == 0 % �����û��������㣬����ջ
            stack = [stack; [x,y]];
        end
        while(~isempty(stack)) % ��ջ�ǿ�
            currentX = stack(end,1);
            currentY = stack(end,2);
            stack(end,:) = []; % ��ջ
            if checked(currentX,currentY) == 1 % ����Ѿ���������㣬������
                break;
            end
            checked(currentX,currentY) = 1;%���õ���Ϊ�Ѽ��
            if I(currentX,currentY) == 0  % ����Ǻ�ɫ�㣨����ɫ����������
                break;
            end
            if isempty(stack)  % ���ջ�գ�˵����һ���µ�����
                currentRegion = currentRegion + 1;
            end
            J(x,y) = currentRegion;
            % �жϰ����������Ƿ��Ѿ�����
            for neighborX = currentX-1:1:currentX+1
                for neighborY = currentY-1:1:currentY+1
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
                    % ����û����������ջ
                    if checked(tempX,tempY) == 0 
                        stack = [stack;[tempX,tempY]];
                    end
                end
            end
        end
       
    end
end
% ��ʾ���
subplot(211)
imshow(logical(I));title('ԭͼI');
subplot(212)
imshow(uint8(J));title('��Ǻ��ͼ��J');
end

% %
% A(end,:)=[] %����ɾ��һ��
% A = [A; [currentX,currentY]]; % �������һ��
% isEmpty(A)�����Ƿ�Ϊ��
% %