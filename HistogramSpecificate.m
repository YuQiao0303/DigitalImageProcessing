function [ J ] = HistogramSpecificate( I,t )
%HistogramSpecificate ��һ����СΪM��N�ĻҶ�ͼ��I�У��Ҷ�Ϊg��������Ϊh(g)�������һ��ֱ��ͼt(g)��
%��д����ͼ��I���б任�ķ�����ʹ�ñ任�����ͼ���ֱ��ͼ��t��ͬ��������ȣ���
[M, N ] = size(I);
J = zeros(M, N);
h = zeros(1,256);
%��ֱ��ͼh 
for x = 1:M
    for y = 1:N
        h(I(x,y)+ 1) =  h(I(x,y)+ 1)+1;
    end
end
%���ۻ��ֲ�rh��rt
rh = zeros(1,256);
rt = zeros(1,256);
for i =1:256
    for j = 1:i
        rh(i) = rh(i) + h(j);
        rt(i) = rt(i) + t(j);
    end
end
%����Ҷȼ������س��ֵ�Ƶ�� frequencySrc �� frequencyDes
frequencySrc = zeros(1,256);
frequencyDes = zeros(1,256);
for i =1:256
    frequencySrc(i) = rh(i) /rh(256);
    frequencyDes(i) = rt(i) /rt(256);
end
%�ҳ���frequencySrc(i)�������frequencyDes(index)��indexֵ
%distance ��frequencySrc(i) �� frequencyDes(index) �Ĳ�
%map���ڼ�¼����i��Ӧ��indexֵ
map = zeros(1,256);
for i = 1:256
    [distance,index] = min(abs(frequencySrc(i)-frequencyDes));
    map(i) = index;
end

%����ӳ��map����ֱ��ͼ�涨��
for x = 1:M
    for y = 1:N
        J(x,y) = map(I(x,y)+1) ;
    end
end
% ��ʾ���
subplot(211)
imshow(uint8(I));title('ԭͼI');
subplot(212)
imshow(uint8(J));title('�涨�������ͼ��J');
end

