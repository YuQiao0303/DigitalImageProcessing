function [end] = regionMarkRecursiveFunction(I,x,y,regionNum)
%regionMarkRecursiveFunction �������㷨�еĵݹ麯��
%��I(x,y),����������������أ���Ϊ�ף�����Ϊ��regionNum�������ڵĵ㣬������ݹ�ؿ���
[M, N ] = size(I);
upX = x-1;
downX = x+1;
rightY = y+1;
leftY = y+1;
% ��Ե����
if x == 1
    upX = 1;
end
if y == 1
    leftY = 1;
end
if x == M
    downX = M;
end
if y ==N
    rightY = N;
end
% ����������
%����
if
end
end

