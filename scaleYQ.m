function [J] = scaleYQ(I,scaleX,scaleY)
%scale :��һ����СΪM��N�ĻҶ�ͼ��I�У���Ҫ��ɣ��Ŵ����С��Ϊ P��Q��ͼ��J����д��J�������㷨��Ҫ��ʹ��˫���Բ�ֵ����
%  ���� D201980953
% ����ͼJ�ϵĵ�(x1,y1),��Ӧԭͼ�ϵĵ�(x,y)
% x,y���������ֱַ�Ϊx0,y0
[M, N ] = size(I);
P = fix(M * scaleX);
Q = fix(N * scaleY);
J = zeros(P,Q);

for x1 = 1:P
    for y1 = 1:Q
        % ��ԭͼ�ж�Ӧ����������
        x = x1 * M / P;
        y = y1 * N  /Q;
        % ˫���Բ�ֵ
        x0 = fix(x);
        y0 = fix(y);
        % ��Ե����
        if x0 == 0
            x0 = 1;
        end
        if y0 == 0
            y0 = 1;
        end
        if(x0 > M -1)
            x0 = M -1;
        end
        if(y0 > N -1 )
            y0 = N -1;
        end
        %��ֵ
        J(x1,y1) =     uint8 ( I(x0,y0)    * (1-x+x0) *  (1-y+y0)  ...
                         + I(x0 +1,y0) * (x-x0)   *  (1-y+y0)  ...
                         + I(x0,y0+1)  * (1-x+x0) *  (y-y0)    ...
                         + I(x0+1,y0+1)* (x-x0)   *  (y-y0));
    end
end
% ��ʾ���
imshow(uint8(I));title('ԭͼI');
figure(2),imshow(uint8(J));title('���ź��ͼ��J');
end

