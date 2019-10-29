function [J] = regionMark(I)
%UNTITLED ����һ����ֵͼ��Ԫ��ȡֵΪ0��1���������ɸ�ͼ��ı��ͼ��
% ������һ����ͨ�����е�ÿһ����ɫ���ص�ֵ����Ϊĳ����ɫ���ڶ�����ͨ�����е�ÿһ����ɫ���ص�ֵ����Ϊ��һ����ɫ���������ơ������ſɲ�����˳��
%   
[M, N ] = size(I);
J = zeros(M, N, 3);
checked = zeros(M,N);
currentRegion = 0;
%��ɫ
colors = [254 67 101;252 157 154;249 205 173;200 200 169;131 175 155;138,151,123;224,208,0;229,131,8;220,87,18;182,194,154;];

% ��ÿһ���㣬����ǰ�ɫ1���򿼲����������������ҵ��ĸ����أ�����δ������ĵ�
% �þ���stack��ʾһ��ջ��ÿ�б�ʾһ�����أ���һ�������ص�x���꣬�ڶ��������ص�y����

%��ʼ��ջ
stack = zeros(M*N,2); 
stackSize = 0;
for x = 1:M
    for y = 1:N
        if checked(x,y) == 0 && I(x,y)==1 % �����û������������ǰ�ɫ������ջ
            %fprintf('˳����ջ��%d %d\n',x,y)
            stackSize = stackSize + 1;
            stack(stackSize,1) = x;
            stack(stackSize,2) = y;
            currentRegion  = currentRegion +1
        elseif checked(x,y) == 0 && I(x,y)==0 % �����û������������Ǻ�ɫ���ͱ��Ϊ�Ѽ��
            checked(x,y) = 1;
            continue;
        else %�Ѿ������ˣ�������
            continue;
        end
        while(stackSize ~= 0) % ��ջ�ǿ�
             % ��ջ
            currentX = stack(stackSize,1);
            currentY = stack(stackSize,2);
            %fprintf('��ǰ�������أ�%d %d\n',currentX,currentY)
            stackSize = stackSize -1;
            
            %fprintf('�������ջ��%d %d\n',currentX,currentY)
            if checked(currentX,currentY) == 1 % ����Ѿ���������㣬������
                continue;
            end
            checked(currentX,currentY) = 1;%���õ���Ϊ�Ѽ��
            J(currentX,currentY,:) = colors(mod(currentRegion,10),:); %ֻ������ʮ����ɫ���������̫�࣬���ٴӵ�һ����ɫ��ʼ��ɫ
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
                    % ����û������Ϊ��ɫ������ջ
                    if checked(tempX,tempY) == 0  && I(tempX,tempY) == 1
                        stackSize = stackSize+1;
                        stack(stackSize,1) = tempX;
                        stack(stackSize,2) = tempY;
                        %fprintf('��Ϊ%d %d��������ջ��%d %d\n',currentX,currentY,tempX,tempY);
                    elseif checked(tempX,tempY) == 0  && I(tempX,tempY) == 0 %δ��飬��ɫ
                        checked(tempX,tempY) = 1;
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