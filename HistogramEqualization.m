function [J] = HistogramEqualization(I)
%HistogramEqualization ��һ����СΪM��N�ĻҶ�ͼ��I�У��Ҷ�Ϊg��������Ϊh(g) �� ��д����ͼ��I����ֱ��ͼ���⻯���õ�ͼ��J�ļ��㷽����
%   �˴���ʾ��ϸ˵��
[M, N ] = size(I);
J = zeros(M, N);
h = zeros(1,256);
%��ֱ��ͼh 
for x = 1:M
    for y = 1:N
        %I(x,y)
        h(I(x,y)+ 1) =  h(I(x,y)+ 1)+1;
    end
end
%���ۻ��ֲ�r
r = zeros(256,1);
for i =1:256
    for j = 1:i
        r(i) = r(i) + h(j);
    end
end
for i =1:256
    r
end
% ֱ��ͼ���⻯
for x = 1:M
    for y = 1:N
        J(x,y) = (r(I(x,y)+ 1) / M*N) * 256;
    end
end
% ��ʾ���
subplot(211)
imshow(uint8(I));title('ԭͼI');
subplot(212)
imshow(uint8(J));title('���⻯���ͼ��J');

% imshow(uint8(I));title('ԭͼI');
% figure(2),imshow(uint8(J));title('���⻯���ͼ��J');
end

