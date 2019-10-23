function [J] = rotateYQ(I,A)
%rotate ��һ����СΪM��N�ĻҶ�ͼ��I�У���Ҫ������ʱ����ת A�ȣ��Ƕ��ƣ����õ�ͼ��J����д��J�������㷨��Ҫ��ʹ�ý��ڲ�ֵ����
%   ��I(x,y)����ת���Ӧ�ĵ�ΪJ(x1,y1)

% ��J��������P/Q
[M, N ] = size(I);
P = round( M * cosd(A) + N * sind(A));
Q = round( M * sind(A) + N * cosd(A));
J = zeros(P,Q);
for x1 = 1:P
    for y1 = 1:Q
        % ��J(x1,y1)��ԭͼI�ж�Ӧ����������(x,y)
        len = sqrt(x1^2 + y1^2);
        theta = atand(x1 / y1);
        %x = len * sind(A + theta) - N * sind(A);
        x = len * sind(A + theta) - N * sind(A);
        y = len * cosd(A + theta);
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
imshow(uint8(I));title('�任ǰ��ͼ��');
figure(2),imshow(uint8(J));title('�任���ͼ��');
end

