function [J] = rotateYQ(I,A)
%rotate ��һ����СΪM��N�ĻҶ�ͼ��I�У���Ҫ������ʱ����ת A�ȣ��Ƕ��ƣ����õ�ͼ��J����д��J�������㷨��Ҫ��ʹ�ý��ڲ�ֵ����
%   ��I(x,y)����ת���Ӧ�ĵ�ΪJ(x1,y1)
% ��J��������P/Q
[M, N ] = size(I);
P = round( abs(M * cosd(A)) + abs(N * sind(A)));
Q = round( abs(M * sind(A)) +abs( N * cosd(A)));
J = zeros(P,Q);

for x1 = 1:P
    for y1 = 1:Q
        % ��J(x1,y1)��ԭͼI�ж�Ӧ����������(x,y)
        % ��������
        x =  (x1-P*0.5) * cosd(A) +  (y1-Q*0.5)* sind(A) + M*0.5;
        y = -(x1-P*0.5) * sind(A) +  (y1-Q*0.5)* cosd(A) + N*0.5;
        
        % ���ڽ���ֵ
        x0 = round(x);
        y0 = round(y);
         % ��J��ֵ
        if x0 < 1 || y0 < 1 || x0 > M || y0 > N
            J(x1,y1) = 0;
        else
            J(x1,y1) = I(x0,y0);
        end
    end
end
% ��ʾ���
imshow(uint8(I));title('ԭͼI');
figure(2),imshow(uint8(J));title('��ת���ͼ��J');
end

        % ����һ��(finished)
%         len = sqrt((x1-(P*0.5))^2 + (y1-Q*0.5)^2);
%         theta = atand((x1-(P*0.5)) / (y1-Q*0.5));
%         if(y1 < Q*0.5)
%             theta = theta + 180;
%         end
%         x = len * sind(theta + A) + M*0.5; 
%         y = len * cosd(theta + A) + N*0.5;


        % ��������
%         translation1 = [1 0 -P/2;0 1 -Q/2;0 0 1];%��ͼ������ĵ�ƽ�Ƶ����Ͻǵ�ԭ��
%         rotate = [cos(A) -sin(A) 0;sin(A) cos(A) 0;0 0 1];%��תangle�Ƕ�
%         translation2 = [1 0 M/2;0 1 N/2;0 0 1];%��ԭ��ƽ�ƻ�ȥ
%         X = translation2 * (rotate * (translation1* [y1;x1;1] ));%P(1)Ϊx��ֵ P(2)Ϊy��ֵ
%         x = X(1);
%         y = X(2);
        