function [end] = regionMarkRecursiveFunction(I,x,y,regionNum)
%regionMarkRecursiveFunction 区域标记算法中的递归函数
%对I(x,y),考察其四领域的像素，若为白，则标记为第regionNum个区域内的点，其继续递归地考察
[M, N ] = size(I);
upX = x-1;
downX = x+1;
rightY = y+1;
leftY = y+1;
% 边缘处理
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
% 考察四领域
%出口
if
end
end

