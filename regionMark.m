function [J] = regionMark(I)
%UNTITLED ����һ����ֵͼ��Ԫ��ȡֵΪ0��1���������ɸ�ͼ��ı��ͼ��
% ������һ����ͨ�����е�ÿһ����ɫ���ص�ֵ����Ϊĳ����ɫ���ڶ�����ͨ�����е�ÿһ����ɫ���ص�ֵ����Ϊ��һ����ɫ���������ơ������ſɲ�����˳��
%   
[M, N ] = size(I);
J = zeros(M, N, 3);
checked = zeros(M,N);
currentRegion = 0;
%��ɫ
colors = [254 67 101;252 157 154;249 205 173;200 200 169;131 175 155;182,194,154;138,151,123;224,208,0;229,131,8;220,87,18];

% ��ÿһ���㣬����ǰ�ɫ1���򿼲����������������ҵ��ĸ����أ�����δ������ĵ�
% �þ���stack��ʾһ��ջ��ÿ�б�ʾһ�����أ���һ�������ص�x���꣬�ڶ��������ص�y����

%��һ������ջ
stack(1,1:2) = [1,1]; 
for x = 1:M
    for y = 1:N
        if checked(x,y) == 0 && (x~=1||y~=1)% �����û��������㣬����ջ
            %fprintf('˳����ջ��%d %d\n',x,y)
            stack = [stack; [x,y]];
        end
        while(~isempty(stack)) % ��ջ�ǿ�
            currentX = stack(end,1);
            currentY = stack(end,2);
            %fprintf('��ǰ�������أ�%d %d\n',currentX,currentY)
            stack(end,:) = []; % ��ջ
            %fprintf('�������ջ��%d %d\n',currentX,currentY)
            if checked(currentX,currentY) == 1 % ����Ѿ���������㣬������
                continue;
            end
            checked(currentX,currentY) = 1;%���õ���Ϊ�Ѽ��
            if I(currentX,currentY) == 0  % ����Ǻ�ɫ�㣨����ɫ����������
                continue;
            end
 
            %fprintf('\n')
            if isempty(stack)  % ���ջ�գ�˵����һ���µ�����
                currentRegion = currentRegion + 1;
            end
            J(currentX,currentY,:) = colors(currentRegion,:);
         
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
                        %fprintf('��Ϊ%d %d��������ջ��%d %d\n',currentX,currentY,tempX,tempY);
                    end
                end
            end
        end
       
    end
end


% ��ʾ���
subplot(121)
imshow(logical(I));title('ԭͼI');
subplot(122)
imshow(uint8(J));title('��Ǻ��ͼ��J');
end

% %
% A(end,:)=[] %����ɾ��һ��
% A = [A; [currentX,currentY]]; % �������һ��
% isEmpty(A)�����Ƿ�Ϊ��
% %