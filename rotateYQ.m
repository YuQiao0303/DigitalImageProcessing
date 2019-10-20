function [ outputPic ] = rotateYQ( inputPic , theta ,mode)
    %UNTITLED2 �˴���ʾ�йش˺�����ժҪ
    %   �˴���ʾ��ϸ˵��
    %������ͼ��С
    [m,n]=size(inputPic)
    mNew = round(m * cos(theta) + n * sin(theta))
    nNew = round(m * sin(theta) + n * cos(theta))
    outputPic = zeros(mNew,nNew);
    %����ͼ�е����ص㸳ֵ
    for i = 1:mNew
        for j = 1:nNew
            % outputPic(i,j) equals the inputPic(x,y)
            % length = distance between the old pixel and [0,0] = x^2 + y^2
            [i,j]
            length = sqrt((i-m+sin(theta))^2 + j^2);
            % alpha = artan( y / x)
            alpha = atan(j/(i - m*sin(theta)) - theta);
            x = length * cos(alpha);
            y = length * sin(alpha);
            % ��ֵ����
            if mode == 0 % ���ڽ���ֵ
                xFinal = round(x);
                yFinal = round(y);
            end
            if xFinal <= n && xFinal > 0 && yFinal <= m && yFinal >0
                outputPic(i,j) = inputPic ( xFinal, yFinal );
            end
        end
    end
    imshow(outputPic);
end

